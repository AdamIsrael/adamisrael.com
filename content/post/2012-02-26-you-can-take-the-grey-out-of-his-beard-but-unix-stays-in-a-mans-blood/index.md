---
title: You can take the grey out of his beard, but Unix stays in a man’s blood.
author: Adam
layout: post
date: 2012-02-26
url: /blog/2012/02/26/you-can-take-the-grey-out-of-his-beard-but-unix-stays-in-a-mans-blood/
dsq_thread_id:
  - 589977216
categories:
  - Uncategorized
tags:
  - administration

---
I sat down this morning, meaning to write a blog post about focus and patience, with OCD tendencies. It would have been my first substantial post since the beginning of the month, but when I logged in to WordPress I found my site unresponsive. Temperamental, even. Other sites I host on the same server, but different accounts, were fine. I was about to blame my half-full cup of coffee when Google interceded and warned me that my site was being suspicious as all fuck. Fuck.

So, instead of talking about how I&#8217;ve been making progress on most of the things and what else I&#8217;ve been doing, I lost the morning to the Unix mines. My old friends _sed_ and _grep_ were happy to see me as we strolled down the old familiar path of forensic analysis and recovery (or, as much as can be done with limited privileges). I don&#8217;t know if my password was compromised or not, but it&#8217;s been changed. One of my WordPress plugins was manually installed and severely out-of-date. It had known XSS vulnerabilities and some of the infected files originated in its folder. It has appropriately been nuked from orbit and installed to current.

Dreamhost&#8217;s been notified, in case this was part of a larger attack on the machine itself. For the time being, all is as it was, or should be at any rate (I&#8217;ll be keeping a close watch for any recurrences).

&nbsp;
