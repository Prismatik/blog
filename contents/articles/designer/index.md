---
title: Designer
author: davidbanham
date: 2015-08-07
template: article.jade
blurb: Manage your CouchDB design docs
---

One of the lovely properties of CouchDB is that it treats code as data. The kinds of things that other databases do with schemas and indexes, Couch does with design documents. These are stored in the database alongside your data.

Nirvana is when you can start your application and have the database look and behave exactly the way it expects. Manually setting up a database and schema before you point an application at it is both error prone and boring.

With something like Postgres (which we love, btw), this typically gets handled with migrations. A database-wide version is stored, and you say things like:

> "In order to move from version 4 to version 5, run these ALTER TABLE statements."

In CouchDB, the equivalent is to PUT some design documents that describe the views/etc you want to exist. You don't express migrations in the sense of

> "Here is the set of actions required to transform this thing."

but rather:

> "This is the way I expect this thing to be. Make it so."

It's more declarative than imperative, which I think is a lovely thing.

You want to make sure that if what you're trying to PUT supersedes what's already there, that it overwrites the existing doc. On the other hand, you want to be sure that out of date versions of your application don't overwrite your shiny new design documents with their rubbish.

I found myself writing the code to do the above job in multiple different applications. [Designer](https://github.com/Prismatik/designer) is a nodeJS library that handles the job for you.
