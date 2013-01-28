---
layout: post
title: Sharing files with virtual machines using NFS
tags:
- virtualisation
- development
- linux
---
In a [previous post](/post/766289691/development-virtual-machines-os-x-using-
vmware-ubuntu), I sang the virtues of [VMWare
Fusion](http://www.vmware.com/products/fusion/overview.html)'s shared folders
feature, and the way it lets one share files from the host OS to the guest OS.

Folder sharing is a bit of a pain to install, especially because OS upgrades
on the guest seem to break the guest tools installation. The solution is one
of the oldest file sharing technologies there is:
[NFS](http://en.wikipedia.org/wiki/Network_File_System_(protocol)). It's easy
to set up, works on basically everything, and is solid as a rock. It also
supports symlinks, which means you can sidestep [VirtualBox's issues with
shared folders and symlinks](/post/766290952/why-i-dont-use-virtualbox).

The best bit is that once it's set up and works you can switch between any
virtualisation technology you like (for example: I'm now using VirtualBox at
work so we can make better future use of [Vagrant](http://vagrantup.com/), but
I use VMWare for Windows)—this works at the OS level so it'll just keep
working.

## Configuration time

This is the easy bit. First we export whichever folder we want to share from
the host OS. In my case it's `~/Projects`. Edit `/etc/exports` as `sudo` (this
won't exist by default on OS X), and add the following line to it:

    
    /Users/bradleyw/Projects -mapall=501:20 -network 192.168.56.0 -mask 255.255.255.0

The first part is obviously the directory you want to share, and the
`-network` flag tells us which IP _range_ to share with. In my case my VM
listens on `192.168.56.101`, hence `192.168.56.0`. The rest of the flags you
can ignore.

Now we need to run a few commands in the OS X terminal to complete this side
of the configuration:

    
    sudo nfsd checkexports
    showmount -e

If everything went well no errors should be reported and your exported
directory should be printed to `stdout`.

Now on the guest OS, you first need to install the NFS software. On Debian and
Ubuntu this is:

    
    sudo apt-get install nfs-common

If you're on another distribution this is an exercise for the reader.

We can now configure `fstab` so `mount` knows what to do. As a super user,
edit `/etc/fstab`, and add the following line at the bottom:

    
    192.168.56.1:/Users/bradleyw/Projects /mnt/nfs nfs soft,intr,rsize=8192,wsize=8192 0 0

The important bits to change are `192.168.56.1`, which should be the IP your
guest can see your host at (so the IP address your virtual machine uses to hit
OS X), the path to your export, and the `/mnt/nfs`, which can be anything you
want. I use `/mnt/nfs` as it seemed the right thing to do.

Note that you need to create `/mnt/nfs` before proceeding: `sudo mkdir -p
/mnt/nfs`.

Now we can attempt to mount the shared filesystem: `sudo mount /mnt/nfs`. If
no errors are reported, it's all good!

You should now be able to read and write from `/mnt/nfs`.

## My own workflow

My own workflow with this is to have a case-insensitive disc image that's
password protected automount on login (this is exported as
`/Volumes/Smarkets`). Then the Linux machine starts in headless mode, and
because of NFS it's already mounted. So I'm up and running very quickly after
logging in, and the case-insensitive disc image gets around all the issues
Python has when exporting from OS X to case-sensitive file systems.

[Hunter](http://binaryclub.com/) helped me a lot with some of the details
here.

  *[NFS]: Network File System
  *[OS]: Operating system

