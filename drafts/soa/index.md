---
title: SOA
author: davidbanham
date: 2015-03-17
template: article.jade
---

At Prismatik we have one core technical principle:

> ###Use the right tool for the job.

One of the ways that this manifests is the way in which we architect our applications. For a lot of things, a service oriented architecture (SOA) is a great choice.

To build an SOA, the first thing you need to do is identify which aspects of your application are separate concerns. Authentication of users and gamification of user actions are two different things. In a traditional monolithic architecture, these would probably be lumped into one process.

(Image depicting monolith)

In an SOA these would be separate services, living in separate repositories, potentially on separate servers. This makes our architecture diagram a little more complex.

(Image depicting SOA)

But it makes the code we write wonderfully simple. In the monolith, we can separate our concerns into modules. That's a fine approach, but it can get messy very quickly. It's all too easy to let state and logic leak from one part of the application to another.

In the SOA, there is a bright line of demarcation between your concerns. Each service can then be further compartmentalised with modules and other code organisation techniques. This really starts paying dividends as your system grows. The maintenance burden of one 10,000 LOC app is about the same as two 6,000 LOC apps. The burden of one 100,000 LOC app is much greater than the burden of ten 6,000 LOC apps.

Let's say we've had an app in production for 12 months. We need to make some changes to the gamification module. Users want different tiers of rewards and we want to introduce a social following system.

In the monolith, your task is "Figure out how the existing logic has been implemented. Track down any intertwined logic. Either refactor it out or ensure your changes don't break anything. Hopefully the last team left you a good test suite." The early part of this task may well entail needing to understand the entire codebase. Not too hard in a 10k app. In a 100k app you might need to work with your team. If you have a 1000k app, call in a project manager to coordinate the discovery process amongst the teams and make sure you're not planning to ship any other features in the near future.

In the SOA your task is the same, but your total possible complexity is limited. It's just a little service. Spend a few hours reading and grokking the 6k LOC, then make your change. There is a clear API contract with the rest of the application to guide you. If it turns out the last developer implemented things badly, just rewrite the thing from scratch. It's a small task with a clear API and you have a reference implementation to work from. You'll be done in no time. Add some extra API surface area to allow other services to subscribe to change events, then go implement that in a separate social following service.

Let's say you want to add the ability to process audio in real time. Most of your codebase is in a high-level interpreted language. That's going to be tricky.

The monolith has a problem. Maybe your language supports native modules? Can you write a library in C then bind to that? It's a shame the only option is C/C++, it would be really nice to be able to do this in go/erlang/haskell/etc.

In the SOA, we get to use the Right Tool For The Job! So long as the service adheres to it's API, the rest of the architecture couldn't care less what language it's implemented in.

Might it have been handy to use a graph/columnar/SQL/noSQL/in-memory database for that one little problem space in your app? No reason you can't in an SOA.

SOA is one of the tools available to us. It helps us build big, complex systems with a small, focused team. These systems then stay predictable and maintainable.

We end up reaching for it a lot.
