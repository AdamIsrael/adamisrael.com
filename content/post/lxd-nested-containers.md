---
author: Adam
categories:
- Technical
date: 2017-06-02T15:29:40-04:00
hidden: false
tags:
- lxd
- containers
title: Nested containers w/LXD
---

A couple days ago, someone asked me why they should care about nested [containers](https://linuxcontainers.org/lxd/introduction/). It's a good question, so I thought I'd talk about how I'm using them.

<center>![Nested containers](/images/stacked_containers.png "It's containers, all the way down.")</center>

Perhaps my favourite benefit of containers is keeping workloads isolated, and not just in terms of process space. It's also a great way to avoid dependency bit rot and version conflicts. I have containers for my home media server, for jenkins, for various database servers that I need for this project or that. I can have containers for different versions of an application. When I don't need something running, I can stop the container. Or export it and copy it elsewhere. Or live migrate it to another machine.

One of the projects I work on is [Open Source Mano](https://osm.etsi.org/), an open source [NFV Management and Orchestration standard](https://www.sdxcentral.com/nfv/definitions/nfv-mano/) aimed at the telecommunications industry, and with anything a) aimed at the telco space and b) relatively new and changing rapidly, there's bound to be some mess involved.

The first release I was involved with was source only, which meant installing all sorts of libraries and compilers, along with forked versions of things I didn't want to use forked versions of for everyday use. And so, I installed it inside a container, but because OSM also uses LXD to run its components in a container, I turned to nested containers.

```bash
# Launch a privileged container with nesting
$ lxc launch ubuntu:16.04 nested-demo -c security.privileged=true -c security.nesting=true

# Set some limits to keep everything playing nicely
lxc config set osmr2 limits.cpu 4
lxc config set osmr2 limits.memory 8GB

# Open a shell inside the container
$ lxc exec nested-demo bash

# Initialize LXD inside the container. I configure the bridge with IPv4, but skip IPv6.
# And we can't use ZFS inside the container (but I always use it on the host!)
root@nested-demo:~# lxd init
Name of the storage backend to use (dir or zfs) [default=dir]: 
Would you like LXD to be available over the network (yes/no) [default=no]? 
Do you want to configure the LXD bridge (yes/no) [default=yes]? 
Warning: Stopping lxd.service, but it can still be activated by:
  lxd.socket
LXD has been successfully configured.

# Verify that LXD is running (and bring up lxdbr0, if it's not already)
root@nested-demo:~# lxc list
Generating a client certificate. This may take a minute...
If this is your first time using LXD, you should also run: sudo lxd init
To start your first container, try: lxc launch ubuntu:16.04

# Launch a couple containers to show them running inside a container
root@nested-demo:~# lxc launch ubuntu:16.04 nested1
Creating nested1
Starting nested1

root@nested-demo:~# lxc launch ubuntu:16.04 nested2
Creating nested2
Starting nested2


root@nested-demo:~# lxc list
+---------+---------+---------------------+------+------------+-----------+
|  NAME   |  STATE  |        IPV4         | IPV6 |    TYPE    | SNAPSHOTS |
+---------+---------+---------------------+------+------------+-----------+
| nested1 | RUNNING | 10.7.101.239 (eth0) |      | PERSISTENT | 0         |
+---------+---------+---------------------+------+------------+-----------+
| nested2 | RUNNING | 10.7.101.155 (eth0) |      | PERSISTENT | 0         |
+---------+---------+---------------------+------+------------+-----------+

```

Now, let's get serious. Say I want to test against various versions of MySQL. I'll create containers for the three most popular versions, and install those versions inside each container. The end result looks like this:

```bash
root@nested-demo:~# lxc list
+---------+---------+---------------------+------+------------+-----------+
|  NAME   |  STATE  |        IPV4         | IPV6 |    TYPE    | SNAPSHOTS |
+---------+---------+---------------------+------+------------+-----------+
| mariadb | RUNNING | 10.7.101.153 (eth0) |      | PERSISTENT | 0         |
+---------+---------+---------------------+------+------------+-----------+
| mysql   | RUNNING | 10.7.101.6 (eth0)   |      | PERSISTENT | 0         |
+---------+---------+---------------------+------+------------+-----------+
| percona | RUNNING | 10.7.101.23 (eth0)  |      | PERSISTENT | 0         |
+---------+---------+---------------------+------+------------+-----------+
```

So I now have three different versions of MySQL available to test. Let's drop out of the container and connect to them from my host machine.

```bash
root@nested-demo:~# exit

# I can see that my nesting container now has two interfaces. The eth0 interface has an 
# IP address provided by the lxdbr0 interface on my host machine, and the lxdbr0 
# interface inside the container is providing IP addresses on the 10.7.101.0/24 network

$ lxc list nested-demo
+-------------+---------+--------------------------------+------+------------+-----------+
|    NAME     |  STATE  |              IPV4              | IPV6 |    TYPE    | SNAPSHOTS |
+-------------+---------+--------------------------------+------+------------+-----------+
| nested-demo | RUNNING | 10.7.101.1 (lxdbr0)            |      | PERSISTENT | 0         |
|             |         | 10.0.3.195 (eth0)              |      |            |           |
+-------------+---------+--------------------------------+------+------------+-----------+

# And the lxdbr0 interface on the host machine provides the 10.0.3.1/24 network:
$ ifconfig lxdbr0
lxdbr0    Link encap:Ethernet  HWaddr fe:36:6f:44:51:75  
          inet addr:10.0.3.1  Bcast:0.0.0.0  Mask:255.255.255.0
          inet6 addr: fe80::e8ce:50ff:fe29:9f8/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:26920105 errors:0 dropped:0 overruns:0 frame:0
          TX packets:91541338 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:42734514276 (42.7 GB)  TX bytes:140021072651 (140.0 GB)


# Add a route between my host machine and the lxdbr0 network inside the container
$ sudo route add -net 10.7.101.0/24 gw 10.0.3.195

# Verify that we can connect to a database
# Note that I've created the user 'root'@'10.0.3.1' in the mysql database,
# since the traffic will be routed over the local lxdbr0 interface.
$ mysql -h 10.7.101.6 -u root --execute '\s'
--------------
mysql  Ver 14.14 Distrib 5.7.18, for Linux (x86_64) using  EditLine wrapper

Connection id:          9
Current database:
Current user:           root@10.0.3.1
SSL:                    Not in use
Current pager:          stdout
Using outfile:          ''
Using delimiter:        ;
Server version:         5.7.18-0ubuntu0.16.04.1 (Ubuntu)
Protocol version:       10
Connection:             10.7.101.6 via TCP/IP
Server characterset:    latin1
Db     characterset:    latin1
Client characterset:    utf8
Conn.  characterset:    utf8
TCP port:               3306
Uptime:                 6 min 43 sec

Threads: 2  Questions: 26  Slow queries: 0  Opens: 111  Flush tables: 1  Open tables: 104  Queries per second avg: 0.064
```

And there you have it: nested containers. Process isolation, dependency isolation, resource isolation, super fast, built in to the kernel and managed through LXD, available when and only when I need them.






