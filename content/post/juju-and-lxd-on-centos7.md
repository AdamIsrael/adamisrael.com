---
author: Adam
categories:
- Technical
date: 2017-01-26T09:45:05+01:00
hidden: false
tags:
- centos
- juju
- lxd
title: juju and lxd on centos7
---

I recently had someone ask me how to test their[Juju] [charm] on centos7. I'll be honest, I haven't voluntarily used an rpm-based distro for a very long time, but I love a good challenge.


# Juju 2.0 on Centos7

## Configure epel repository
```
yum -y install epel-release
yum repolist
```
## Install LXD

Install lxc libraries
```
yum -y install python-requests
rpm --nodeps -i https://copr-be.cloud.fedoraproject.org/results/alonid/yum-plugin-copr/epel-7-x86_64/00110045-yum-plugin-copr/yum-plugin-copr-1.1.31-508.el7.centos.noarch.rpm
yum copr enable thm/lxc2.0
yum -y install lxc lxc-devel
```
### Build from source

```
yum install -y golang-bin git make dnsmasq squashfs-tools
mkdir ~/go
export GOPATH=~/go
```

```
go get github.com/lxc/lxd
cd $GOPATH/src/github.com/lxc/lxd
make
```

### Add to path

```
cp $GOPATH/bin/* /usr/bin
```
### Start LXD daemon

We want to setup systemd to manage LXD, and ensure that LXD will start after a reboot.

Create the file `/etc/systemd/system/lxd.service` with the following contents:
```
[Unit]
Description=LXD Container Hypervisor
Requires=network.service

[Service]
ExecStart=/usr/bin/lxd --group lxd --logfile=/var/log/lxd/lxd.log
KillMode=process
TimeoutStopSec=40
KillSignal=SIGPWR
Restart=on-failure
LimitNOFILE=-1
LimitNPROC=-1
```

Once you've saved that file, enable, start, and set the service to start on boot:

```
mkdir -p /var/log/lxd
systemctl enable lxd
systemctl start lxd
ln -s /etc/systemd/system/lxd.service /etc/systemd/system/multi-user.target.wants/lxd.net
```

### Configure LXD

The first time LXD is run, we need to setup the storage backend and virtual network bridge. For optimal performance, we recommend using zfs-backed storage. Create a virtual network bridge, enabling ipv4 but disabling ipv6.
```
lxd init
```

### Testing LXD

Launch an instance to verify that LXD is working. The first launch of an image will take the longest because it needs to download (and cache) the image.
```
lxc launch ubuntu:16.04
lxc list
```

## Install Juju
```
curl -o juju-2.0.2-centos7.tar.gz -L https://launchpad.net/juju/2.0/2.0.2/+download/juju-2.0.2-centos7.tar.gz
tar zxf juju-2.0.2-centos7.tar.gz
mkdir -p  /usr/lib/juju-2.0/bin
cp juju-bin/* /usr/lib/juju-2.0/bin
update-alternatives --install /usr/bin/juju juju /usr/lib/juju-2.0/bin/juju 1
```

Once this is completed, Juju is installed on your system. You can confirm this by running `juju`, which will display usage information.



## Configuration

### SSH
```bash
mkdir ~/.ssh
chmod 700 .ssh
ssh-keygen -t rsa
```








[Juju]:
[charm]:
