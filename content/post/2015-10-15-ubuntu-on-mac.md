---
title: Ubuntu on Mac
author: Adam
layout: post
date: 2015-10-15
url: /blog/2015/10/15/ubuntu-on-mac/
masonry_settings:
  - 'a:1:{s:4:"size";s:2:"11";}'
ljID:
  - 385
ljURL:
  - http://stonetable.livejournal.com/98751.html
categories:
  - Technical
tags:
  - linux
  - ubuntu
  - ubuntu on mac

---
I recently rebuilt a Mac Mini to work as the forth screen in my workflow. I googled around and pieced together what I needed to do by cherrypicking from various guides, and everything was running well until I updated to a new kernel and rebooted. I spent the better part of two nights trying to get the machine to boot.

Unfortunately, it happened just after I blacklisted a module to work around a USB bug that was causing one of my drives to go haywire occasionally, and it took a while before I finally figured out it wasn&#8217;t a problem with my change but the kernel itself. Mac&#8217;s use EFI for booting &#8212; which requires a cryptographically signed kernel. I was finally able to boot up by following the first half of the instructions on [this][1] Ask Ubuntu answer. Essentially, do a manual boot via grub and make sure that I pick the secure kernel.

I noticed that I only had a signed image for an older version of the Kernel. I dropped by #ubuntu-kernel and was pointed to the **linux-signed-generic** package. What happened is none of the guides I read had mentioned this package or its significance. Any time the kernel images are updated, the signed version is also updated, except you won&#8217;t get that image by default. The machine was trying to boot off an unsigned kernel, causing the boot sequence to freeze (with no indication as to why).

<pre class="lang:sh decode:true " >sudo apt-get update
sudo apt-get install linux-signed-generic
sudo reboot</pre>

A thorn with an easy fix. Install the meta package, which will pull in the current signed image, and reboot.

 [1]: http://askubuntu.com/questions/392723/trying-to-single-install-on-macbook-pro-but-wont-automatically-boot-from-new-os/550027