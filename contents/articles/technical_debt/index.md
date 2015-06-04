---
title: Technical Debt
author: davidbanham
date: 2015-06-04
template: article.jade
blurb: Technical debt is a sharp tool. Use it wisely.
---

> #### Technical debt is simultaneously the most difficult and most important concept we must communicate to our clients.

Debt is a tool like any other. Paying for things on a high interest credit card is often okay.

It's especially okay if you're purchasing an asset that will earn you money at a higher rate of return than the interest you're paying. Incurring debt is fine, provided you have the means to support the obligation.

You must never forget that the debt exists. You must either repay the principal or continue paying the interest. If you take too long repaying the principal, the cumulative interest payments will wipe out the profit you made on the asset.

### Let's map this analogy back to software
Your team has a level of equilibrium. __This is the pace at which they can add new features while still having time to consolidate, test and refactor.__ This pace can be maintained indefinitely. Pushing them beyond this level is putting features on your credit card.

Your credit card has interest. As time goes on, every feature you wish to add in the future will take longer and have more bugs.

This interest compounds, too. The longer the principal remains unpaid, the more workarounds and quick fixes your team will need to implement.

To repay that princpal, you need to spend some time on the technical fundamentals of your product. Accept a slower pace of new features in exchange for making it significantly easier to add new features in the future. Your reward will be increased feature velocity and a happier, more engaged team. Chances are, you'll end up with some performance benefits along the way. (You know [how important performance is to your users](http://www.fastcompany.com/1825005/how-one-second-could-cost-amazon-16-billion-sales), right?)

Your development team already knows exactly where and how to invest this time.

### But software isn't really like finance, right?
Well, the analogy gets a lot more real when you recall that you pay your developers with money.

If you increase the pace of your feature development today beyond a sustainable level, you will impact the future productivity of your team. You can regain that productivity either by lessening the pace of feature development or buying more development capacity. The former costs you money by lessening the ROI of your wage bill. The latter costs you money by, well, costing you money.

I hear your inner accountant stirring. Before you start looking up your current benchmark [IRR](https://en.wikipedia.org/wiki/Internal_rate_of_return) and calculating [NPV](https://en.wikipedia.org/wiki/Net_present_value), though, the economists need to have their turn. As always, there are [externalities](https://en.wikipedia.org/wiki/Externality) to be considered.

The entire time this situation is going on, your product is slower, buggier and less stable than it needs to be. That's a very difficult thing to price.

Finally, you can only grow your team so large before it becomes [unwieldy and unproductive](https://en.wikipedia.org/wiki/Diminishing_returns). You can only pile so many band-aids on top of one another before the whole tower comes [toppling over](https://en.wikipedia.org/wiki/Cyclomatic_complexity). Eventually, the bank will become concerned about your capacity to repay and will make a [margin call](https://en.wikipedia.org/wiki/Margin_%28finance%29#Margin_call).

The key things to keep in mind are:

1. The principal must be repaid.
1. The interest compounds.
1. Don't let yourself be surprised by that margin call.
