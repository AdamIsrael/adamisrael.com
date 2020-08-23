---
author: Adam
categories:
- Technical
date: "2017-05-30T14:59:56-04:00"
hidden: false
tags:
- ubuntu
- lxd
- xenial
title: Nested LXD on Ubuntu 16.04.2 (Xenial)
---


*Edit -- 1 Jun 2017*: The issue is a problematic patch that caused a breakage between 2.0.9 and 2.13. LXD 2.0.10 is currently in the SRU review queue, and once it lands in xenial-updates the problem should go away.

tl;dr: Nested LXD containers on Ubuntu 16.04.2 (Xenial) will break if you're running LXD 2.12+ on the host machine, because the Xenial cloud image ships with LXD 2.0.9 and a version conflict between host and container causes nesting to fail.

Sometime in the last couple of months, [nested lxd containers on Ubuntu 16.04 broke](https://github.com/lxc/lxd/issues/3172). A [fix](https://github.com/lxc/lxd/pull/3194) landed a week later. Unfortunately, the patch hasn't been applied to the version of lxd (2.0.9-0ubuntu1~16.04.2) in xenial-updates, so a new privileged container, by default, won't be able to launch nested containers.

```bash
$ lxc launch ubuntu:16.04 lxd-test -c security.privileged=true -c security.nesting=true
$ lxc exec lxd-test bash
$ lxc launch ubuntu:16.04
Generating a client certificate. This may take a minute...
If this is your first time using LXD, you should also run: sudo lxd init
To start your first container, try: lxc launch ubuntu:16.04

Creating coherent-reptile
Starting coherent-reptile           
error: Error calling 'lxd forkstart coherent-reptile /var/lib/lxd/containers /var/log/lxd/coherent-reptile/lxc.conf': err='exit status 1'
  lxc 20170530162611.740 ERROR lxc_apparmor - lsm/apparmor.c:apparmor_process_label_set:234 - No such file or directory - failed to change apparmor profile to lxd-coherent-reptile_</var/lib/lxd>//&:lxd-coherent-reptile_<var-lib-lxd>:
  lxc 20170530162611.740 ERROR lxc_sync - sync.c:__sync_wait:57 - An error occurred in another process (expected sequence number 5)
  lxc 20170530162611.740 ERROR lxc_start - start.c:__lxc_start:1346 - Failed to spawn container "coherent-reptile".
  lxc 20170530162612.281 ERROR lxc_conf - conf.c:run_buffer:405 - Script exited with status 1.
  lxc 20170530162612.281 ERROR lxc_start - start.c:lxc_fini:546 - Failed to run lxc.hook.post-stop for container "coherent-reptile".

Try `lxc info --show-log local:coherent-reptile` for more info
```

LXD, installed from xenial-updates, doesn't contain the patch for this bug:

```bash
$ apt-cache policy lxd
lxd:
  Installed: 2.0.9-0ubuntu1~16.04.2
  Candidate: 2.0.9-0ubuntu1~16.04.2
  Version table:
     2.13-0ubuntu3~ubuntu16.04.1 100
        100 http://archive.ubuntu.com/ubuntu xenial-backports/main amd64 Packages
 *** 2.0.9-0ubuntu1~16.04.2 500
        500 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 Packages
        100 /var/lib/dpkg/status
     2.0.2-0ubuntu1~16.04.1 500
        500 http://security.ubuntu.com/ubuntu xenial-security/main amd64 Packages
     2.0.0-0ubuntu4 500
        500 http://archive.ubuntu.com/ubuntu xenial/main amd64 Packages

```

To fix this, you need to make sure the version of LXD in the nested container matches that of the host machine. In other words, if you're running LXD from backports or ppa, you should install that version in the nested container as well.


Alternatively, you can downgrade your host machine's LXD to 2.0.9, but be warned that this may break any existing containers.
