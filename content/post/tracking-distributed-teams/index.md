---
title: "Tracking Distributed Teams"
date: 2019-11-16T07:52:04-08:00
draft: false
author: Adam
categories:
  - Technology
tags:
  - remote work
hidden: false
header:
    image: ""
    caption: ""
summary: ""
---

One challenge of working on a distributed team is keeping track of everyone's time zone. The last thing I want to do is message someone outside of business hours.

To that end, I went looking for an application that could show me, at a glance, what time it was for my colleagues.

## Snap: teamtime

Try to find the first one I tried. It was an application that I snap installed onto maidalchini before the reinstall. Might be an artifact of it left in ~/snap

## Gnome extension: Timezone

Next I found the GNOME Timezone extension. It runs as an AppIndicator that, when clicked, will display a list of

<img src="/home/stone/Sites/adamisrael.com/static/img/gnome-timezone-extension.png" alt="GNOME Timezone extension" />

It works by parsing a json file containing the name, timezone, city, and (optionally) an avatar to use for each entity.



file:///home/stone/.local/share/people/people.json