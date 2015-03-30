---
title: SOA
author: davidbanham
date: 2015-03-17
template: article.jade
---

At Prismatik our core technical principle is:

> ###Use the right tool for the job.

One of the things this results in is how we architect applications. For a lot of the things we build, a service oriented architecture (SOA) is a great choice.

Step one in building an SOA is to separate your application into concerns. Authentication of users and gamification of user actions are two different things. In a traditional monolithic architecture, these would probably be lumped into one process.

(Image depicting monolith)

In an SOA these would be separate services, living in separate repositories, potentially on separate servers. This makes our architecture diagram a little more complex.

(Image depicting SOA)

But it makes the code we write wonderfully simple. In the monolith, we can separate our concerns into modules. That's a fine approach, but it can get messy very quickly. It's all too easy to let state and logic leak from one part of the application to another.

In the SOA, there is a bright line of demarcation between your concerns. Each service can then be further compartmentalised with modules and other code organisation techniques. This really starts paying dividends as your system grows. The maintenance burden of one 10,000 LOC app is about the same as two 6,000 LOC apps. The burden of one 100,000 LOC app is much greater than the burden of ten 6,000 LOC apps.

## Benefits to team structure

It's certainly possible to build a monolith with a big team. It takes an awful lot of teamwork, though.

Lots of developers in the same repository, working on the same code, altering the same logic, making changes to shared models. It becomes really easy to step on each other's toes. This introduces collaboration overhead. Merge conflicts, big standups, cross-team meetings to co-ordinate work.

There's just no other way to deal with a 100,000 LOC product, though. It's more than one or two people can handle.

If you're doing SOA right, though, each unit of functionality should be about the right size to hand to one or two developers. Tell them to call you if they hit a road block or once they're finished.

That's not even the best bit, though! Each service has a clearly defined API. Deciding that up front takes a bit of planning effort. Remember, though, you're just desinging the API and not the implementation.

The benefit to this is that your teams are no longer dependent on one another. It doesn't matter that Bob hasn't completed the authorisation service yet. Alice can still get on and build the gamification service, since she knows what Bob's service is going to expect and what it's going to return.

## Benefits to maintainability

Let's say we've had an app in production for 12 months. We need to make some changes to the gamification module. Users want different tiers of rewards and we want to introduce a social following system.

In the monolith, your task is "Figure out how the existing logic has been implemented. Track down any intertwined logic. Either refactor it out or ensure your changes don't break anything. Hopefully the last team left you a good test suite." The early part of this task may well entail needing to understand the entire codebase. Not too hard in a 10k app. In a 100k app you might need to work with your team. If you have a 1000k app, call in a project manager to coordinate the discovery process amongst the teams and make sure you're not planning to ship any other features in the near future.
In the SOA your task is the same, but your total possible complexity is limited. It's just a little service. Spend a few hours reading and grokking the 6k LOC, then make your change. There is a clear API contract with the rest of the application to guide you. If it turns out the last developer implemented things badly, just rewrite the thing from scratch. It's a small task with a clear API and you have a reference implementation to work from. You'll be done in no time. Add some extra API surface area to allow other services to subscribe to change events, then go implement that in a separate social following service.

Let's say you want to add the ability to process audio in real time. Most of your codebase is in a high-level interpreted language. That's going to be tricky.

The monolith has a problem. Maybe your language supports native modules? Can you write a library in C then bind to that? It's a shame the only option is C/C++, it would be really nice to be able to do this in go/erlang/haskell/etc.

In the SOA, we get to use the Right Tool For The Job! So long as the service adheres to it's API, the rest of the architecture couldn't care less what language it's implemented in.

Might it have been handy to use a graph/columnar/SQL/noSQL/in-memory database for that one little problem space in your app? No reason you can't in an SOA.

SOA is one of the tools available to us. It helps us build big, complex systems with a small, focused team. These systems then stay predictable and maintainable.

We end up reaching for it a lot.
