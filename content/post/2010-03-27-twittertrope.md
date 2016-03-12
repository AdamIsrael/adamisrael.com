---
title: Twittertrope
author: Adam
layout: post
date: 2010-03-27
url: /blog/2010/03/27/twittertrope/
aktt_notify_twitter:
  - yes
ljID:
  - 288
aktt_tweeted:
  - 1
dsq_thread_id:
  - 175204629
categories:
  - Uncategorized
tags:
  - duotrope
  - twitter

---
I was updating my submission tracker on [Duotrope][1] this morning, after receiving a rejection from Writers of the Future. I was [tweeting][2] about the rejection when I had a slight epiphany. I realized how cool it would be if Duotrope had Twitter integration. They don’t, and as I discovered, neither do they have any presence on Twitter. I decided then and there that something must be done to correct this oversight.

After an hour or two of hacking, in between a heated battle between myself and my XBox, I finished today’s secret project: the [unofficial Duotrope Twitterfeed][3].

Why did I do this? Well, all too often I come across writers who have never heard of Duotrope. I know, right? Twitter is a good way to boost the signal. I also am nerdy enough that I like seeing what’s changing in the fiction landscape on a regular basis and Duotrope is the place to go for that.

For the technically inclined, this is powered by a 140 line perl script (including comments and whitespace) that downloads the RSS feed from Duotrope every 30 minutes or so and checks for new updates. Every new item, as determined by the feed’s guid, has a short url generated for it by way of [is.gd][4], has its description shorted as necessary and is then posted to Twitter.

DISCLAIMER: I am not affiliated with Duotrope in any way. I’m just a fan of their service and have taken it upon myself to spread the word about them.

 [1]: http://www.duotrope.com/
 [2]: http://twitter.com/AdamIsrael/status/11158086587
 [3]: http://twitter.com/Duotrope
 [4]: http://is.gd/