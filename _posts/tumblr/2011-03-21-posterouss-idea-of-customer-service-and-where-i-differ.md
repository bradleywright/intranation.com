---
layout: post
title: Posterous's idea of customer service, and where I differ
tags:
- startups
- posterous
- smarkets
---
I've been dabbling with [Posterous](http://posterous.com/) as a potential way
of mitigating Tumblr's recent downtime issues.

The tl;dr version is that I didn't like their service, and suggest some
improvements.

## My experience with Posterous

After importing my Tumblr blog into their system (which was all very smooth),
I tried to edit a post and remove it, using one of their combo buttons:

![Combo button](http://s3.intranation.com/blog/posterous-customer-service
/posterous-combo-button.png)

Unfortunately, in both Safari and Chrome (so WebKit, basically), their
Javascript is broken. It fails, and then fails to clobber the event
propagation, so the page reloads (as obviously, not being progressively
enhanced, all their links are empty).

A cursory look in my console shows really basic errors like:

    
    Uncaught TypeError: Cannot call method addClassName of null

or:

    
    Uncaught TypeError: Property $ of object [object DOMWindow] is not a function

Now, being the responsible developer I am, I write into them with a bug report
(this is on January 29, almost 2 months ago):

> Every time I click the "Edit | [down arrow]" button (the down arrow
specifically), the page goes to a blank page. I assume this is because the JS
is broken so you're not cancelling the click event on the link. I'm using
Safari 5.0.3 on Snow Leopard.

Not the most gracious email, I'm sure we can all agree, but then again this
also seems like the kind of basic error that shouldn't happen in the first
place.

Yesterday, on March 20th (almost 2 months after submitting the error report),
I get the following response from Posterous:

> Hello Brad,

>

> Should you still be experience the issue you emailed us about, try clearing
safari's cache and cookies and trying again, or using another browser.

>

> Sorry for the delayed response,

>

> Theodore

I mean, what? This is a fundamentally broken part of the site, and the best
they can tell is is:

  * They haven't tried verifying that the bug still exists (or even existed in the first place);
  * They certainly haven't tried to fix it; and
  * Their solution is to clear everything or use another browser.

And I waited two months for that? As a professional developer it's my educated
opinion that the errors I describe above are easy to notice and probably easy
to fix. And they can't even be bothered checking them.

No thanks Posterous, I'll be sticking where I am for now.

## What I would have done

At [Smarkets](http://smarkets.com) customer service is a part of our business
that we take very seriously. I would have responded roughly as follows:

  * Reply within a day, telling the customer we'll look into it, and apologise for the inconvenience they're experiencing (note that this is mostly a form letter, and thus is very easy to reply with);
  * Work out if there's actually a bug:
    * If there is, file it, and schedule a fix; or
    * If not, work out why the user is experiencing it anyway.
  * Reply to the user with either your explanation for what they might be doing wrong, and find out if they can give you more information; or
  * Tell them when they can expect a fix, as you've found the bug. Give them some kudos in the email for finding the bug for them.

At a startup, every customer is valuable and should be treated like they're
important and that their opinion matters. These are trivial things to get
right, and prevent long-winded disgruntled blog posts like this.

  *[tl;dr]: Too long; didnt read

