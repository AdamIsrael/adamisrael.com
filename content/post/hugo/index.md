---
author: Adam
categories:
- Technical
date: 2016-03-15T18:47:58-04:00
hidden: false
tags:
- hugo
- wordpress
- cloudflare
- dreamhost
title: Migrating to Hugo
---

[Hugo](1), the static website engine, not the [award](2).

I've grown frustrated with Wordpress and Dreamhost. Running a Wordpress site
on a shared web host is a ticking time bomb. More users crowded on a server. I
threw turned on caching and Cloudflare; readers should have had little trouble
using the site, but my sessions were consistently timing out while using the
admin dashboard, which makes posting new content a frustrating experience.

<!--more-->

Wordpress on it's own is fine, especially on dedicated servers. I've run
hundreds of thousands of requests/day through Wordpress and it can handle it
well, as long as you give it the right hardware.

Dreamhost, as well, isn't at fault. I pay for fairly cheap hosting, and they
don't have much control over the efficiency of the apps that their shared
hosting customers run.

So in comes Hugo.

There's a bunch of static site generators around, like jekyll or octopress. I
wanted to write in Markdown, I wanted it to be fast, and I wanted it to be
flexible. After playing around with a few generators, I was sold.

I can basically write a blog post really quick, save it, and run a script that
will generate the static pages, commit the changes to Github, and rsync it to
this site.

There may be a few formatting errors in the older posts, but I imported
everything from Wordpress, converted it to Markdown, and kept all of the
permalinks the same. All told, maybe twelve hours of work and I have a blog
I'm not frustrated to look at anymore.

[1]: https://gohugo.io/
[2]: http://www.thehugoawards.org/
