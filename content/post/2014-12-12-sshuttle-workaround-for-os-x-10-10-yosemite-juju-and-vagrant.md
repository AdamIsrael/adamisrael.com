---
title: sshuttle workaround for OS X 10.10 (Yosemite), Juju and Vagrant
author: Adam
layout: post
date: 2014-12-12
url: /blog/2014/12/12/sshuttle-workaround-for-os-x-10-10-yosemite-juju-and-vagrant/
masonry_settings:
  - 'a:1:{s:4:"size";s:2:"11";}'
categories:
  - Technical
tags:
  - ipfw
  - juju
  - os x
  - sshuttle
  - vagrant
  - yosemite

---
<p class="p2">
  <a href="https://github.com/sshuttle/sshuttle">sshuttle</a> is a nifty little transparent proxy/vpn that works by tunneling TCP traffic over SSH, or more specifically, tearing down a TCP session and reassembling the data on the other side. I started using it earlier this year, as part of my workflow using <a href="https://juju.ubuntu.com/">Juju</a> and developing under OS X. It&#8217;s like a data center in a box, inside another box. Code locally in my editor of choice (vim, TextMate, and more recently, Atom). Deploy new code. Refresh web browser, thanks to sshuttle. With sshuttle, I could connect to the services running within my virtual machine running Ubuntu natively through OS X.
</p>

<p class="p2">
  Until I upgraded to Yosemite (OS X 10.10).
</p>

<p class="p2">
  ipfw, the FreeBSD ip packet filter, was replaced by OpenBSD&#8217;s pf in OS X 10.7, but the binary lived on through 10.9. sshuttle has no support for pf, which led me googling down a spiraling trail of despair and hope that someone, some day, would patch sshuttle.
</p>

<p class="p2">
  I&#8217;m more familiar with iptables than either ipfw or pf, but I understand enough networking to know that ubuntu-in-a-virtual-machine was already setup to talk to the outside world. I figured that there must be something more obvious than setting up a poor man&#8217;s VPN to talk to it.
</p>

<p class="p2">
  A few hours of testing later, I had a working solution using the route command.
</p>

<pre class="lang:sh decode:true ">$ sudo route add -net 10.0.3.0/24 172.16.250.15</pre>

The lxc containers run on the 10.0.3.0 network, and the lxc host (always, in the official Vagrant image) has eth1 bound to 172.16.250.15.

There&#8217;s a few ways I could have implemented this. I could have made it a static route, always active, but that could lead to unintended side-effects if you were to join a network using the same ip range. Same logic rules out adding it to my ~/.bash_profile. I ended up finding vagrant-triggers, which allows you to run custom commands at various stages of the vagrant lifecycle. With that, I can add the route when I boot up a virtual machine, and remove it when I&#8217;ve shut it down.

<p class="p2">
  While I can confirm that it works for me, I can&#8217;t say how well it&#8217;ll work for other use cases of sshuttle or earlier versions of OS X. Juju users can head over to the <a href="https://juju.ubuntu.com/docs/howto-vagrant-workflow.html">Vagrant Workflow</a> docs for the latest and greatest, or read on for the <a href="https://gist.github.com/AdamIsrael/cc51d3d704c18095f718">gist</a>.
</p>

<p class="p2">
  <!--more-->
</p>

> <p class="p3">
>
> </p>