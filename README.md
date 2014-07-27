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

* **An High Availability (HA) system**. This howto is based mainly in Proxmox. Actually the HA system needs the OVH fencing.
* **OVH dedicated server**. This howto only makes sense if you are using dedicated servers in OVH datacentres.
* **Proxmox setup as a cluster**. We assume that Proxmox is already setup as a [cluster](https://pve.proxmox.com/wiki/Proxmox_VE_2.0_Cluster).
* **Proxmox mostly setup as an HA cluster**. We assume that you have begun to setup Proxmox as an [High Availability cluster](https://pve.proxmox.com/wiki/High_Availability_Cluster) and you are stuck at setting up a fencing agent inside OVH infraestructure.
* **Vrack** . This is actually not strictly needed. However we recommend you to purchase [Vrack](https://www.ovh.co.uk/solutions/vrack/)  to ease Proxmox cluster communication setup. You will also have one dedicated network device for service and another one for communications as most suggested network setups. These are other technical pages about Vrack: [Vrack 1.0](http://help.ovh.co.uk/vrack) , [Vrack 1.5](http://help.ovh.co.uk/VrackInfrastructure) . Vrack 2.0 (Being able to connect servers from different datacentres around the world) is supposed to come soon.
* **RipeVrack** . This is actually not strictly needed. If you are used to setup your virtual machines network configuration as [Bridgeclient in OVH](http://help.ovh.co.uk/BridgeClient) we recommend you to switch to [RipeVrack](http://help.ovh.co.uk/RipeVrack) which it's the most suited for HA (no need to change .254 gateway).
* **OVH application keys**. This is needed in order your OVH fencing agent to work. Don't worry if you don't have these OVH application keys because we will cover their generation in this howto.

OVH application keys generation
-------------------------------

Manual installation
-------------------

Setting up your cluster.conf
----------------------------

