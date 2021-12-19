---
title: "Silverblue on Framework"
date: 2021-12-03T14:13:52-06:00
draft: true
categories:
- Technical
tags:
- framework
- silverblue
---

A few weeks in to receiving the Framework laptop, Jorge convinced me to give Fedora Silverblue a spin.

Switching distro's is a big ask, but Jorge is the one who turned me on to Ubuntu way back when it was no no-name-yet.

Coming from Ubuntu, I have certain expectations about my desktop.
For several days, I ran Silverblue 34 and 35 beta in a virtual machine

So I made a made a backup of my $HOME and installed Silverblue 34 (35 was days away from release).

<!--more-->


## What is Silverblue?

[Silverblue](https://silverblue.fedoraproject.org/) is an immutable desktop operating system.

Basically, /etc and /home are writeable, but everything else is read-only, making up the layered file system. You use rpm-ostree, in a very git-like fashion, to stage or rollback updates to the operating system, and reboot to take effect.

## Containerization

As a software engineer, most of my work these days runs in the cloud. Kubernetes, usually. So the idea if doing my daily work in a container had some appeal.

The other selling point for me was the tight integration with [podman] and [toolbx]. 


The idea is that you can run multiple containers, using any flavour of Linux, specific to a tool or project. As someone who bounces around between projects and languages, I can create containers for specific purposes, either per-client or per-project, or even per-language or application.

The containers are so tightly integrated that you can run a GUI application from inside a container and it works natively with your desktop.

## Applications


There's three ways of installing an application:

1. Flatpak: this is how you get most of your GUI applications
2. Toolbox: primarily for CLI packages, or GUI packages that aren't available in a Flatpak
3. Package layering: drivers and whatnot, through there are exceptions

### Flatpak

This is the default way you should be installing GUI applications. 

### Toolbox

Installing software in a toolbox is good for installing CLI apps, or even GUI apps that aren't available in Flatpak. Yes, you can run a GUI application from inside a toolbox and it'll work exactly as expected.

### Package Layering

In the case where Flatpak or Toolbox don't make sense, you can use `rpm-ostree install <package name>` to install it as a layered package.



## ublue

Part of Jorge's pitch to switching to Silverblue was a little project he started called ublue. Basically, make the transition from Ubuntu to Silverblue a little less jarring by installing some applications by default, building an Ubuntu image for toolbx, installing fonts, and taking a selection of the familiar defaults of the Ubuntu desktop and apply them to GNOME under Silverblue.



## Workflow

I took this as an opportunity to refactor some of my [dotfiles](). I 

I use zsh + rocketship.rs. 


Open a terminal, and `toolbox enter <client>`


## Things that would be nice to have


### Power profiles

It would be nice to be able to define a power profile. For example, I want to optimize towards performance if I'm connected to a power source, but automatically switch to power-savings when I switch to battery. 

Some of this is specific to the Framework and it's battery life, which is something they're working to improve through bios/firmware updates.


### Network profiles

We used to have [laptop-net](http://groups.csail.mit.edu/mac/projects/omnibook/documentation/laptop-net.html). In essence, if I connect to my home network, I want to automatically do things differently -- start an openssh server, change my wallpaper, etc. Inversely, if I disconnect from a trusted network, I want to lock down my network.
