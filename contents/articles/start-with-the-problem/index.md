---
title: Start with the problem, not the solution
author: samanderson
date: 2016-03-11
template: article.jade
blurb: Reducing surprise by planning for the unexpected.
---

> The key measure of success for the design phase is lack of surprises

System design is an accepted part of software development, and it only takes one bad experience of developing a project without a design to cement the worth of a design-first philosophy. A common mistake made by teams adopting a design-first philosophy is attempting to solve all of the problems which have been uncovered during the system design phase. Although the goal is admirable, this sort of thinking can result in a number of negative effects for both the product and the team.

The most important part of the system design phase is to uncover future problems; fixing them is a secondary concern. Many of the most costly mistakes made during software development occur when a previously unforeseen problem is discovered. By this stage, previous development has often either removed many of the options that would solve the problem, else adopting the solution would invalidate previous development efforts. This can be avoided when developers and designers have prior knowledge of the problems which will ultimately require solutions, allowing them to take these into account throughout the development process.

This does not mean that a problem can be completely ignored once it has been identified. The best-case scenario is for these issues to be solved prior to development, but this is often not practical. A reasonable outcome for unsolvable problems is a range of proposed solutions ideated for each problem, without firmly deciding on one. Having this list of solutions makes it easier to assess the future impact of a given solution, and easier to map to it and discuss it. By the time that it comes to actually develop the solution for the original unsolved problem, it will have been considered multiple times and from multiple angles as part of other development decisions, and the solution will become apparent far more easily and naturally.

The key measure of success for the design phase is lack of surprises and less unforeseen problems occurring during development. Yes, it is lovely to have a system that is perfectly mapped out with all problems solved at the start, but that is impractical for most projects, and impossible for many. Trying to achieve the impossible in the design phase will quickly stymie the creativity of both designers and developers, leading to a bad outcome for everyone.