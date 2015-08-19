---
title: A Journey Of Discovery
author: nathanwinch
date: 2015-08-20
template: article.jade
blurb: Ways to gather the right intel.
---

The discovery phase of a project is both daunting and exciting. It is where
project goals are moulded from the clay of a scope document, into tangible
milestones that will be reached in the near future. Here we validate
the _why_ of all the things and have the choice of a myriad of different
methods available to tickle out the right information which will help you
solve the directional puzzle that is the discovery phase. I recently stared
down the barrel of this phase with and saw it as a great opportunity to get my
hands dirty with some practices I'd never tried before.

The goal of this article is to provide a high level summary of methods we use
here at Prismatik to home in on the core essentials we need to kick off a
build process. There are plenty of helpful articles out there that explain each
method in more detail, so I'll only be taking a shallow dive into each and
provide links as I go on what I found useful if you'd like to learn more.

### Personas
First we start with personas; a way to model and summarize known and suggested
assumptions you make about the intended users of your product. They allow you
to build empathy with your users and help keep a frame of reference when
designing and building features. We work through personas with the client -
at least two for each user type — and knuckle down what personas will be
relevant for the first phase of the project. These are undoubtedly the corner
pieces of your puzzle.

### User stories
Next we move on to user stories; a breakdown of each task a user can accomplish
within the product experience. Personas slot comfortably into your user stories
as the _role_ of the story. User stories help remind the team of user
motivations and most importantly, why a user wants to do things.

One aspect of the user stories we have recently introduced into our work flow
are *acceptance criterias*. These define what checks off the user story as
complete as long as the criteria is met. They can also be used to help develop
story tasks, and subsequently used later during QA (double bonus!). We use
[Taiga](https://taiga.io) for managing user stories and have found it to be a
great addition to our tool belt.

### API
We've arrived in API land; all of us are big fans of
[JSON Schema](http://json-schema.org) here at Prismatik and modelling your
resources with well defined schemas is a solid start. Our chief geek
[David Banham](https://twitter.com/davidbanham) has given an
[insightful presentation](http://slides.davidbanham.com/little_schema) on
the topic and I'd recommend you give it a read.

In the beginning you may need to make assumptions about how resources might be
modelled. These loose ends can be tightened up during the discovery phase as
you revisit your schemas in an iterative fashion. It's important to ensure that
your API is a source of truth for the project, as any issues with your API will
amplify tenfold further down the road with your application logic. You don't
want that. We use [Heroku's PRMD tool](https://github.com/interagent/prmd) to
generate API docs.

### User flows
Now for something more visual; a representation of the user's flow to complete
tasks within the product. User flows are represented from the user's
perspective and should clearly identify each step taken. Concise and granular
works best — some user flows can be wickedly long — as this helps to keep
actions on point and make them digestible for discussion and improvement.
Creating user flows is a great method to work in sync with your client. The
visualisation of these flows helps everyone provide a rationale as to why a
user should be doing things to achieve things, and it becomes clear uberfast if
there are holes in the process, or superfluous actions being mapped for a user
that don't tie in with your project goals. We use a combination of
[hand sketched](https://signalvnoise.com/posts/1926-a-shorthand-for-designing-ui-flows)
flows (because our drawing skills are mad good brah) and
[Balsamiq](https://balsamiq.com).

### Prototype
We arrive at our final delivery; We have toyed with the idea of delivering UX
documents and/or complete site experiences; Though a prototype feels like the
right thing to place in your client's hands. Client's don’t _read_ their product;
they _use_ their product. Creating something usable is a good way to summarise
all of the previous methods undertaken and makes for a powerful presentation
when you can step your client through the journey of using their product. A
prototype nicely laces up decisions and rationale and a strong focus should be
made on content hierarchy and page/feature composition. There are different
levels of complexities for prototypes; they can range from a simple point and
click wireframe adventure, to something that entails feature functionality. The
decision depends on the project, time and budget available; Recently we
created a prototype using
[Google's Material Design Lite](https://github.com/google/material-design-lite)
and this got the job done nicely.

Trying new and different discovery methods for projects is something to be
encouraged as each project presents a unique set of challenges. Hopefully by
diving further into some of the above, it might seem a little less daunting and
may inspire you to develop and tweak your own work flow to find the right fit.
