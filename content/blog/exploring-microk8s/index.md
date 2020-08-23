---
author: Adam
categories:
- Technical
date: "2018-10-05T22:28:19-04:00"
draft: true
hidden: false
tags:
- kubernetes
- microk8s
title: Exploring microk8s
---


# Secrets

An object store for sensitive information

## Create a secret

```bash
$ kubectl create secret generic mysql-pass --from-literal=password=mypassword
secret/mysql-pass created
```

## Get secrets

```bash
$ kubectl get secrets
NAME                  TYPE                                  DATA   AGE
default-token-z4rk8   kubernetes.io/service-account-token   3      7d1h
mysql-pass            Opaque                                1      4s
```

# Deploy

## Peristant storage

IMPORTANT. Enable storage before creating a service in microk8s, or your volume will be stuck in pending.

Bug: If you enable storage after a request to create a persistant volume, the request will stay in pending. I had to delete the volume and re-create it.

```bash
$ microk8s.enable storage
Enabling default storage class
deployment.extensions/hostpath-provisioner created
storageclass.storage.k8s.io/microk8s-hostpath created
Storage will be available soon
```

It can take a few minutes for the persistent volume to be created.
```bash
NAME             STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS        AGE
mysql-pv-claim   Bound    pvc-663bb5ad-c915-11e8-9d99-28d244449944   20Gi       RWO            microk8s-hostpath   3m9s

```

```bash
$ kubectl get pvc
NAME             STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
mysql-pv-claim   Pending
```

## Mysql

Deploy mysql, which will create our mysql service and create a persistant storage volume.

```bash
$ kubectl create -f ~/Projects/wp-k8s/mysql-deployment.yaml
service/wordpress-mysql created
persistentvolumeclaim/mysql-pv-claim created
deployment.apps/wordpress-mysql created
```

kubectl get pods


## Wordpress

```bash
$ kubectl create -f ~/Projects/wp-k8s/wordpress-deployment.yaml
service/wordpress created
persistentvolumeclaim/wp-pv-claim created
deployment.apps/wordpress created
```

kubectl get pvc

We should now see to persistent volumes, one for mysql and one for wordpress. See scaling for why this is a good.

```bash
$ kubectl get services wordpress
NAME        TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
wordpress   LoadBalancer   10.152.183.242   <pending>     80:31224/TCP   5m26s
```

Browse to http://10.152.183.242. You'll see the Wordpress installation page. Go ahead and click through to configure Wordpress, and continue here once you've reached the dashboard.

# Benchmarking

First, we'll establish some baseline benchmark metrics

```bash
$ ab -n 1000 -c 4  http://10.152.183.242/
[..]

Concurrency Level:      4
Time taken for tests:   20.571 seconds
Complete requests:      1000
Failed requests:        0
Total transferred:      52137000 bytes
HTML transferred:       51875000 bytes
Requests per second:    48.61 [#/sec] (mean)
Time per request:       82.286 [ms] (mean)
Time per request:       20.571 [ms] (mean, across all concurrent requests)
Transfer rate:          2475.04 [Kbytes/sec] received
```

## Scale

On the base install, I'm getting around 48 requests/second.
With two frontend servers, that drops to

Whats the difference between scaling a deployment vs. scaling a resource?

Scale this up
```bash
$ kubectl scale --replicas=2 rs/wordpress-557bfb4d8b
```
