---
title: Codescreen
author: davidbanham
date: 2015-07-22
template: article.jade
blurb: A better way to screen candidates
---

Many pixels have burned out discussing how terrible technical interviews are for everyone involved. At Prismatik, that's part of our strength. Recruiting, retaining and managing the best software developers is _really hard_. The fact that we're excellent at doing that is our point of differentiation.

A critical part of a technical interview is to answer the question:

> Can this person actually write code?

Having someone produce fibonacci numbers on a whiteboard is horrible. It's a completely alien environment for starters. Your text editor/IDE, language and API documentation, Google, Stack Overflow, etc are all tools of trade. It's like asking a carpenter to frame a wall with nothing but a big rock. Next, you're probably not in the business of selling fibonacci numbers. Anything complex enough to be relevant to your business is probably too much for a whiteboard.

A better approach is to let someone complete a code screen task in their own time, on their own laptop, in their own home.

To help with this, we've developed a super simple git server. We ask our candidates to spend no more than 30 minutes on the problem. That gives us a fair basis on which to compare candidates. It also respects our applicants by setting a reasonable cap on the amount of unpaid labour they may feel compelled to do.

A candidate checks out a git repository from a unique URL. They read their challenge in the README contained in the repo. They write their solution using whatever tools they like, just like they would at work. When they're done making commits, they push their repo back. We take note of how long they spent on the challenge.

They can push multiple times if they forgot something and there's no hard time limit. We're interested in assessing skills, not thinning the herd with gotchas.

If you're interested in using our tool, check it out here:

[https://github.com/Prismatik/codescreen](https://github.com/Prismatik/codescreen)
