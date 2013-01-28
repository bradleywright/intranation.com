---
layout: post
title: Issues mounting shared folders in VMWare Fusion 3
tags:
- virtualisation
- development
---
I recently took advantage of the [VMWare 3 upgrade for only $9.99
USD](http://www.vmware.com/vmwarestore/fusion_upgrade_promo.html), which has
all gone well, except for one issue with `/etc/fstab`: it turns out that
VMWare Fusion 3 tools doesn't actually respect your mount settings, which
means you lose all the permissions information contained therein.

There's [a solution to the mount problem here](http://dmoonc.com/blog/?p=288),
which works perfectly after a reboot. I hope VMWare fixes this soon, though:
it's a pretty nasty bug.

