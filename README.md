OVH fencing agent documentation
===============================

Introduction
------------

This documentation helps using OVH fencing agent. Documentation is aimed at a Proxmox installation but can be easily adapted to other HA systems. You are supposed to have been able to setup your Proxmox installation as a cluster and begun to setup it as an HA cluster. As per having a server in OVH datacentre you need a fencing mechanism but OVH does not deliver a direct fencing mechanism. The alternative, which it's coded into this fence agent, is to reboot your machine into the OVH rescue mode.

The documentation, although it's kind of offtopic will also cover how to create your OVH application keys. The reason is that working with these OVH application keys is very recent and, the other reason, is that you need these keys if you want Fencing to work.

The repository that hosts this fencing agent won't contain fencing agent binaries but some auxiliar files which we might mention and link to.

If you need more information on why you need a fencing agent in your HA installation please check: https://fedorahosted.org/cluster/wiki/FAQ/Fencing#fence_manual3

Index
-----

* [Requirements](#requirements)
* [OVH application keys generation](#ovh-application-keys-generation)
* [Manual installation](#manual-installation)
* [Setting up your cluster.conf](#setting-up-your-clusterconf)

Requirements
------------

OVH application keys generation
-------------------------------

Manual installation
-------------------

Setting up your cluster.conf
----------------------------

