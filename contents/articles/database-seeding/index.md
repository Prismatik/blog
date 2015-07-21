---
title: Review Apps and Database Seeding
author: simontaylor
date: 2015-07-21
template: article.jade
blurb: Keeping it lean and clean.
---

For our feature development we use [Feature Branching](https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow) workflow. The tl:dr is:

* We create a separate branch for each new feature we work on. 
* Once the feature is complete we create a PR.
* We then get this peer reviewed (by another developer) before merging.
* We update the branch based on any feedback we received.
* Finally merge the PR into master (master should always be production-ready).

This can make it tricky to conduct user/client testing. Two options you have are...

* Merge all the features into master at the end of an iteration, push to staging and then request the client does their testing. This means the client doesn't see any features until the end of an iteration. It also somewhat pollutes `master` since you can't call a feature production ready until the client/UAT have signed off.
* Push to a staging server from within your feature branch **before** you merge into master. The client can then test each feature independently, which is great! Once they sign off, that branch can then be merged into master. The caveat is that it makes it difficult to test multiple branches concurrently. Developers must collaborate to know who's currently using the staging environment for their pet feature. You often up with multiple staging environments to reduce this contention.

Wouldn't it be great if each feature branch could have its own private staging environment? Enter Heroku with [Review Apps](https://devcenter.heroku.com/articles/github-integration-review-apps)!

Review Apps allows you to easily spin up a completely seperate app for any PR you've created on github! This is a big step forward as it allows each feature to be tested completely independently. Only once it is given the OK by the client is it merged into master.

A gotcha here is that you don't want each of these apps to share the same database. If your feature contains a schema change you're going to have a bad time.

The ideal state is to have a separate database for each PR app. For this to work we need to seed some data into the database for the client to use. At a bare minimum we'd need to create user accounts so the client can actually login to test! This lead me down the path of looking into a solution to re-seed our database every time we spin up a new PR app.

To give this some context...

* This is a nodeJS codebase
* The project uses Mongo as the database and Mongoose as the database interface
* The data structure is actually fairly relational, despite using a document database
* I’ll use the example of a customer model that has many users to illustrate the problem

Seeding a database is a relatively trivial task. All you need to do is create a bunch of dummy data that conforms to your schema. The only challenging aspect of this is the relationships that exist between the models. The legacy code we had in place to seed the database was written within several javascript files that are executed when starting the app if the database is fresh.

There were two aspects I didn’t like about the existing implementation. Firstly, it seemed overly complex in the way it handled relationships. There were nested functions using the id of the model created by the outer function. Secondly, there was no separation between the dummy data we were seeding and the javascipt code that created this data (the data was stored inline within the javascript files).

My first thought was to store all the data we wanted to seed in json format. This way the data itself doesn't contain any code, it's reasonably easy to read by humans and is fairly trivial to change. As mentioned we use Mongoose to connect to our database, and this allows you to create models in bulk by passing an array of objects into a .create() method so it just needs to read the json and pass it to the Mongoose method for that model.

The challenge was in how to define the relationships. Originally I thought these couldn't be stored in json file so went down the path of codifying the relationships. i.e. we create a "customer" first, then to create the users, we read the users in the json file, append the customer id to every user object and then pass these to .create(). This felt gross as the json data was not then representative of the final model state. I really didn't want the relationships only defined within my code.

One of my colleagues, [Andri](https://github.com/moll), then suggested that you can just define the id within the json file. Mongoose allows you to define the id (_id) for an object rather than allowing it to generate one. Since relationships in Mongoose are just a string conforming to a docId, you can then just populate all ther relationships manually. This was a great suggestion as it avoids needing to "codeify" any of the relationships. I literally threw out half the code I had written. (I challenge you to find a better feeling than a commit that has negative LOC.) The only downside to this approach is with Mongo the ids are a 24 character hex string (A-F, 0-9 characters only). Seeing that a user is a child of customer "a000000000000000000000001" was not the level of readability I was aiming for.

It then occured to me, why not do a simple substitution using some placeholders for my ids? In the json file if I have a customer named "Simon's Brewery", I can define an id of $Simon's-Brewery$. Then for all the user models I can also define their customer_id as $Simon's-Brewery$. Then, all I need to do within the code is generate a valid mongo id, and replace all instances of $Simon's-Brewery$ with it before I seed the database. This gives me a nicely readable json file that defines my relationships _and_ keeps relationship definitions completely out of my code. I've used $text-here$ as the format for my mongo id placeholders but you could use any format you want if you can find it with a regex.

Some psuedo code...

* Read the json file (don't use require as this parses the json file!)
* Find all the placeholders within the file.
* Filter the placeholders to just unique placeholders
* Generate a mongo id for each unique placeholder
* Substitute each placeholder with the mongo id you created for it (the same mongo id will be assigned to all placeholders with the same name)
* Parse the string now all the substitutions are done
* Pass your string into the relevant .create() methods

Ultimately I'm pretty happy with the solution as it's fairly simplistic (just uses find and replace) and keeps all my seed data including relationships in my json file! This also allows developers to update the seed data file any time they change the data structure without updating any code. The final piece of the puzzle is to write some code to auto-create a new database each time we spin up a PR app and then seed this data into it. For this I'll need to take a closer look at the Mongolab API but that is a story for another day...
