---
author: Adam
categories:
- Technical
date: 2017-05-30T14:59:56-04:00
hidden: false
tags:
- ubuntu
- lxd
- xenial
title: Nested LXD on Ubuntu 16.04.2 (Xenial)
---
tl;dr: Nested LXD containers on Ubuntu 16.04.2 (Xenial) are currently broken by default. You need to install the lxd package from backports.

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

To fix this, you need to explicitly install lxd from backports. *Do not use the lxd/stable PPA, as it is targetted at the most recent release, not the latest LTS release.*

```bash
# Update your host OS
apt update
apt install -t xenial-backports lxd

# Create a new privileged container w/nesting
lxc launch ubuntu:16.04 lxd-test -c security.privileged=true -c security.nesting=true

# Update it to the latest LXD in backports
lxc exec lxd-test bash
apt update
apt install -t xenial-backports lxd

# Verify you can launch a nested container
lxc launch ubuntu:16.04

```

If you still encounter the above error, it may be necessary to purge lxd before installing the version in backports. I suspect this happens when you used an earlier version of lxd and upgraded to the later version with this bug. **This will remove all existing containers**:


```bash
apt remove --purge lxd
apt install -t xenial-backports lxd
```






