---
title: "Tracking Distributed Teams"
date: 2019-11-22T07:52:04-08:00
draft: false
author: Adam
categories:
  - Technology
tags:
  - remote work
  - open source
  - gnome
hidden: false
header:
    image: ""
    caption: ""
summary: ""
---

One challenge of working on a distributed team is keeping track of everyone's time zone. Most of my immediate team are Europe-based, and my colleagues in the Open Source Mano project are spread across the world. That makes timely collaboration complex. I often need to coordinate a task with someone several timezones away. If I miss them, I have to wait until my next day to talk to them. Not very efficient.

To that end, I went looking for an application that could show me, at a glance, what time it was for my co-workers and colleagues.

What I found, and ultimately settled on, is a GNOME extension called Timezone. It runs as an AppIndicator that, when clicked, will display a table of time zones and people in them.

<img src="/img/gnome-timezone-extension.png" alt="GNOME Timezone extension" />

It displays the time in red if it's outside the person's working hours, which is a nice visual cue. I know it's too late to get a reply from them, so I'd best send an email that they can see during their next business day.

It works by parsing a json file containing the name, timezone, city, and (optionally) an avatar to use for each entity.

```json
[
    {
        "name": "David",
        "city": "Bilbao",
        "github": "davigar15",
        "tz": "Europe/Madrid"
    },
    {
        "name": "Dominik",
        "city": "Madrid",
        "avatar": "file:///home/stone/.local/share/people/dominik.jpg",
        "tz": "Europe/Madrid"
    },
    {
        "name": "Jayant",
        "avatar": "file:///home/stone/.local/share/people/jayant.jpg",
        "tz": "Asia/Kolkata"
    },
    {
        "name": "Arno",
        "city": "Belgium",
        "avatar": "file:///home/stone/.local/share/people/arno.jpg",
        "tz": "CET"
    },
    {
        "name": "Tytus",
        "avatar": "file:///home/stone/.local/share/people/tytus.jpg",
        "city": "Poland",
        "tz": "CET"
    },
    {
        "name": "Eduardo",
        "city": "Portugal",
        "avatar": "file:///home/stone/.local/share/people/eduardo.jpg",
        "tz": "GMT"
    }
]
```

It's feature-light (it would be nice to have a settings page to manage people instead of creating a json file), but the important thing is that it works well for what it does.

The source can be found on <a href="https://github.com/jwendell/gnome-shell-extension-timezone">Github</a> and can be installed from <a href="https://extensions.gnome.org/extension/1060/timezone/">GNOME Extensions</a>.


