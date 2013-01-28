---
layout: post
title: Why I don't use VirtualBox
tags: 
---
This article is really nothing more than me pointing at a link to [my own
article about virtualisation on a Mac](http://intranation.com/entries/2009/03
/development-virtual-machines-os-x-using-vmware-and/). [Benjamin
Thomas](http://benjaminthomas.org/) has written his own article about
[virtualised Linux development using
VirtualBox](http://benjaminthomas.org/2009-11-15/virtualbox-development-
virtual-machines.html). His article covers all same details as mine, but with
specific regard to VirtualBox, so I suggest you read that if you’re after
VirtualBox information.

However, I had some issues with VirtualBox that I thought were worth
outlining:

  * VirtualBox file sharing [doesn’t support symbolic or hard links](http://www.virtualbox.org/ticket/818), which also means that my [much–used virtualenv](http://intranation.com/entries/2009/12/python-virtualenv-quickstart-django/) doesn’t work correctly. This is a deal breaker for me, basically;
  * Networking from host to guest can be a pain, as evidenced by [Stuart Colville’s post regarding host–only network adapters](http://muffinresearch.co.uk/archives/2010/02/08/howto-ssh-into-virtualbox-3-linux-guests/);
  * Somewhat subjectively, I don’t much like VirtualBox from an interface perspective, and as VMWare seems like a pretty smart company (see their [recent Redis talent acquisition as proof](http://blogs.vmware.com/console/2010/03/vmware-hires-key-developer-for-redis.html)) I’m happy to continue supporting them.

Incidentally, I discovered Benjamin’s post through my own ego–tastic [Google
Alerts](http://www.google.com/alerts).

