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
* **OVH application keys**. This is needed in order your OVH fencing agent to work. Don't worry if you don't have these [OVH application keys](https://api.ovh.com/g934.first_step_with_api) because we will cover their generation in this howto.

OVH application keys generation
-------------------------------

### Introduction

OVH introduced a new RESTful based API in 2014. This API has a different approach for authentication than the older SOAPI one. Basically it helps the OVH user to avoid handling their OVH account user and password to their sysadmins.

Why? Because application or software that uses OVH RESTful API use a separated pair of keys for identifying themselves and a third key in addition for being able to interact with the RESTful API.

The other improvement is that the application is not granted all the OVH RESTful API methods to be able to interact with. You can specify which API requests the application can only interact with.

### Requirements

* curl program

### Who is in charge on generating OVH application keys

The Proxmox HA system sysadmin does not need to deal with OVH application keys. In order to make HA work it only needs **AK**, **AS** and **CK** for the fencing application. Your general sysadmin (the one with right for knowing OVH account user and password) should deal with this **AK**, **AS** and **CK** generation.

Alternatively you can handle OVH account user and password to your Proxmox HA system sysadmin temporarily while it makes: **AK**, **AS** and **CK** and then change the OVH account password.

### Creation of your application keys

Click on the following link: https://eu.api.ovh.com/createApp/, enter your customer ID, your password, and the name of your application. If your bussiness is called **mybu** we recommend you to use: **mybu-fencing-agent** as the application name.

You get two keys:
* the application key, named **AK**, e.g:
`7kbG7Bk7S9Nt7ZSV`

* your secret application key, named **AS**, e.g:
`EXEgWIz07P0HYwtQDs7cNIqCiQaWSuHF`

### Requesting an authentication token from OVH

We will request a token from OVH to enable the OVH fencing agent to make requests to the API. Specifically we will only ask for being able to perform these requests:

* PUT /dedicated/server/{serviceName} (Change boot device)
* POST /dedicated/server/{serviceName}/reboot (Hard reboot your dedicated server)
* GET /dedicated/server/{serviceName}/task/{taskId}




Manual installation
-------------------

Setting up your cluster.conf
----------------------------

