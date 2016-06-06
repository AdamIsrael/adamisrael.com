---
author: Adam Israel
categories:
- Technical
date: 2016-06-02T13:42:46-04:00
hidden: false
tags:
- juju
- perfkit
- benchmarking
title: Perfkit and Juju
---


*State the problem*

Performance is hard. That's why there are so many tools to measure it. Getting to the bottom of the performance monkey barrel requires a deft hand and good aim. Requirements change, hardware is in flux, and bottlenecks shift.

*Solution is benchmarking*

Performance is hard, but benchmarking isn't (or shouldn't be). There are many tools to do it, and we've had an emergence of benchmarking suites, like the [Phoronix Test Suite](http://www.phoronix-test-suite.com/), that collect individual benchmarks into one package.

*Differences between this and normal machine benchmarking*

With the shift (find different word to compliment cloud) to the cloud, we have more access to hardware (the benefit) but less control over it (the drawback).

All hardware (in the cloud) is not equal.
*Enter perfkit, the why and the how.*

Perfkit is interesting for a couple reasons. It's from Google, and Google has a pretty good grasp on performance (said tongue-in-cheek, add relevant links to emphasis that). It's also cloud-centric, which means

*Awesome upstream gushing chapter*

*We want the guys who work on perfkit to be like “Wow, those Canonical guys really love our stuff”*

*Sample benchmark*

*Do everything on GCE, we’ll let the user infer they can do this anywhere*

*Set everything up, with perfkit driving juju*

*Show results*

*Awesome graph porn*

*Conclusion*

*Using perfkit? You have all of this already, it’s included!*

*Try to not make it a commercial about Juju, the tone should be something more akin to “well of course it comes with some Juju features, how else would anyone do this?” *
