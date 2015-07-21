---
title: Review Apps and Database Seeding
author: simontaylor
date: 2015-07-21
template: article.jade
blurb: Keeping it lean and clean.
---

For one of our internal projects we recently decided we needed a better way to perform end user testing on the new features we develop.

For our feature development we use [Git Flow](https://guides.github.com/introduction/flow/index.html) workflow. The core concept of Git Flow is that master is always production ready (it's always safe to push what's in master to production). At a high level our workflow is...

* We create a separate branch for each new feature we work on. 
* Once the feature is complete we create a PR.
* We then get this peer reviewed (by another developer) before merging.
* We update the branch based on any feedback we received.
* Finally merge the PR into master.

One of the issues with Git Flow is how to conduct end user testing. Two options you have are...

* Merge all the features into master at the end of a sprint, push to staging and then request the client does their testing. This means all your features are tested at the end of a sprint, rather than as soon as they are ready which is a bottleneck but more importantly this is clearly in opposition with the Git Flow principal that master is production ready. If the client is still testing its not production ready.
* Push to a staging server from within your feature branch **before** you merge into master. The client can then test each feature independently which is great and once they sign off that specific feature can then be merged into master. But the caveat to this is it makes it difficult to test multiple branches concurrently as after the client finishes testing one branch on a staging server, you need to force push the next feature to staging before they can test the next feature (creating a bottleneck).

Fortunately Heroku recently released a new [Review Apps](https://devcenter.heroku.com/articles/github-integration-review-apps) feature to beta!

This effectively allows you easily spin up a completely seperate app for any PR you've created on github! This is a big step forward as it allows each feature to be tested completely independently and only once it is given the OK by the client only then is it merged into master.

One of the issues with this approach though is that all apps will share the same database (in our case the database url is configured as an environment variable). This can cause unusual issues to occur as if the data model is changed by the code within a PR, it is modifying the same database used by all other PRs that don't include this code! This is also a problem if we are just pushing from a feature branch to a staging server, even without using PR apps.

To explain why this is a problem, imagine we need to repurpose an existing field so that it now stores a string instead of a boolean. As part of our feature we write a migration that converts all saved booleans to the string we expect. This has now permanently modified the contents of our database and if we were to then test with a PR that does not contain this change and still expects the field to be a boolean. Worst case scenario this may crash our app but it may also just cause weird test results that the client does not expect.

So the ideal state is to have a separate database for each PR app. But for this to work we need to seed some data into the database for the client to use. At a bare minimum we'd need to create user accounts so the client can actually login to test! This lead me down the path of looking into a solution to re-seed our database every time we spin up a new PR app.

To give this some context...

* The project in question is for an external client who likes to perform user testing on features before delivery
* The project uses Mongo as the database and Mongoose as the database interface
* The data structure is fairly relational, despite using a NoSQL database
* I’ll use the example of a customer model that has many users to illustrate the problem

Seeding a database is a relatively trivial task, all you need to do is create a bunch of dummy data that conforms to your schema. The only real challenging aspect of this is the relationships that exist between the models. The legacy code we had in place to seed the database was written in some javascript files that run when starting the app when the database was fresh.

There were two aspects I didn’t like about our existing implementation. Firstly, it seemed overly complex in the way it handled relationships with nested functions using the id of the model created by the outer function. Secondly there was no separation between the data to be seeded and the code that created the data (the data was inside a javascript file).

My first thought was using .json to store the data that we will use to seed. This way the data itself doesn't contain any code, it's reasonably easy to read by humans and is fairly trivial to change. As mentioned we Mongoose to connect to our database, and this allows you to create models in bulk by passing an array of objects into a .create() method so it just needs to read the json and pass it to the Mongoose method for that model.

But the challenge was in how to define the relationships. Originally I thought these couldn't be stored in json file so went down the path of codifying the relationships. i.e. we create a "customer" first, then when we create users we append the customer id from the customer we created to each object before creating the users. This felt gross as the .json data was not then representative of the final model state, I really didn't want the relationships only defined within my code.

One of my colleagues [Andri](https://github.com/moll), then suggested that you can just define the id within the json file. Mongo allows to define the id (_id) for an object yourself and in doing so you can then use this id to define the relationship on any related objects. This was a great suggestion as it avoids needing to "codeify" any of the relationships. The only downside to this approach is with Mongo the ids are a 24 character hex string (A-F, 0-9 characters only). So I can create customer "a000000000000000000000001" and then use "a000000000000000000000001" as the customer_id on each of my users but it's not exactly readable... It's not so bad if you're just creating one customer as it's obvious which one you're referencing but what if you created 100 and were trying to look at the json file to figure out which customer you'd linked a user to.

So the principal was great but it wasn't readable. It then occured to me, why not do a simple substitution? In the json file if I have a customer named "Simon's Brewery" I can put $Simon's-Brewery$ as the Customer's id and also use $Simon's-Brewery$ as the customer_id on any related models. Then, all I need to do within the code is generate a valid mongo id, and replace all instances of $Simon's-Brewery$ with this mongo id, before I seed the database. This gives me a nicely readable json file that defines my relationships and keeps relationship definitions completely out of my code. I've used $text-here$ as the format for my mongo id placeholders but you could use any format you want if you can find it with a regex.

Some psuedo code...

* Read the json file (don't use require as this parses the json file!)
* Find all the placeholders within the file.
* Filter the placeholders to just unique placeholders
* Generate a mongo id for each unique placeholder
* Substitute each placeholder with the mongo id you created for it (the same mongo id will be assigned to all placeholders with the same name)
* Parse the string now all the substitutions are done
* Pass your string into the relevant .create() methods

Ultimately I'm pretty happy with the solution as it's fairly simplistic (just uses find and replace) and keeps all my seed data including relationships in my json file!