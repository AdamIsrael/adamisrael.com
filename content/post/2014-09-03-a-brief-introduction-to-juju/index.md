---
title: A brief introduction to Juju
author: Adam
layout: post
date: 2014-09-03
url: /blog/2014/09/03/a-brief-introduction-to-juju/
ljID:
  - 381
ljURL:
  - http://stonetable.livejournal.com/97670.html
categories:
  - Technical
tags:
  - juju

---
I had some concerns about how I was going to integrate posts of a technical nature with my blog, which has been predominantly writing-oriented for several years. What I failed take into account is that many of us who write Science Fiction are armchair technologists. We look at gadgets, scientific breakthroughs and tech policy, and make conjecture about what might come next.

What I talk about is less important than _how_ I talk about it. It’ll be interesting, or not, but no self-rejection.

Onward.

In one of my previous jobs, I ran a cluster of servers responsible for serving upwards of 1.5 _Billion_ ads/day. I had a half dozen racks of hardware sitting in a data center in Chicago. Some of those servers were from the early days, while others were a few years newer.

When business was good, we&#8217;d buy more equipment &#8212; servers, racks, switches, electricity, and bandwidth &#8212; to handle the traffic. The new business justified the fixed and recurring costs (to buy and lease hardware, and to host the equipment), locked in to a 1-3 year contract.

When business dropped off, and it inevitably did, we were still paying the bills for all of that extra hardware and the associated services.

There&#8217;s also an ebb and flow to internet traffic, an inevitable tidal force. We might serve twice as many ads after 9AM EST as we did at 3AM. So you beefed up hardware to handle the daily peaks and pay for the idle costs otherwise.

Almost everyone in the modern world today carries a cell phone. Maybe you buy the latest and greatest smartphone, at a subsidized price, and are locked into a contract, paying every month for the privilege, even for the services you never use. Or you buy your phone outright and pay as you go, only responsible for what you use.

This is where the cloud comes in. You can almost see the Jedi hand wavy motion being made when someone says, &#8220;it&#8217;s in the cloud&#8221;. What is this ethereal thing and where does it live?

The simplified version is that the cloud is simply a large cluster of computers sitting in a data center somewhere. It might be massive, power-consuming supercomputers. It could be a ton of off-the-shelf hardware stringed together. And all of that gear is pieced together with software to run virtual computers, which those companies will the lease out to people like you and me.

There’s no question that the future of business computing involves the cloud. It&#8217;s super cost-effective. In may ways, though, it&#8217;s still in its infancy.

Here&#8217;s where I get to the point, and talk about Juju.

Back when I was managing that cluster of ad servers, we&#8217;d cobbled together a mix of shell scripts using ssh and puppet to automate the deployment and management of those dozens of computers. It worked, but was far from ideal, and only worked with our hardware.

[Juju](1) is a system that lets you automate the deployment of software, via bundled instructions called _Charms_, to servers across multiple Clouds, like EC2, Azure, HP, Digital Ocean, or even your own hardware.

Say your awesome website is suddenly getting linked to by the Neil Gaiman and John Scalzi&#8217;s of the world, and your site is being crushed under the load. Problem?

No problem. You tell juju you want two more servers, or five or ten. A few minutes later, they&#8217;re online and so&#8217;s your website. When the [slashdot effect](2) has worn off, you can remove those extra servers. Only paying for the time use you needed them.

Scalability and affordability, in a nutshell. And juju is there to help you manage that.

TL;DR: Juju is a cloud orchestration toolkit, to aid in the deployment and manage of services across a variety of cloud providers.

 [1]: https://juju.ubuntu.com/
 [2]: http://en.wikipedia.org/wiki/Slashdot_effect
