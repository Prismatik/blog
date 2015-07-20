---
title: Seeding a Database
author: simontaylor
date: 2015-07-21
template: article.jade
blurb: Keeping it lean and clean.
---

We semi-recently discovered the awesome new Heroku feature that is “PR Apps”. This effectively allows you easily spin up a completely seperate app for any PR you've created on github. It’s a great feature and enables users to test each feature independently without needing to merge your PR which allows you to keep any fixes as the result of user testing inside your PR.

[https://devcenter.heroku.com/articles/github-integration-review-apps](https://devcenter.heroku.com/articles/github-integration-review-apps)

To make the most of this feature, we want to also maintain a separate database for each PR app as issues can arise when they share a single database if any schema changes have been made. A key piece in getting this up and running is how to seed the database? At a minimum we need to seed some users so that the client can login to the app to conduct their testing but we also ideally want to create some dummy data.

To give this some context...
The project in question is for an external client who likes to perform user testing on features before delivery
The project uses Mongo as the database and Mongoose as the database interface
The data structure is fairly relational, despite using a NoSQL database
I’ll use the example of a customer model that has many users to illustrate the problem

Seeding a database is a relatively trivial task, all you need to do is create a bunch of dummy data that conforms to your schema. The only challenging aspect of this is the relationships that exist between the models. The legacy code we had in place to seed the database was written in some javascript files that run when starting the app when the database was fresh.

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