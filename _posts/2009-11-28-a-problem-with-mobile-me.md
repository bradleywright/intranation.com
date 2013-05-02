---
layout: base
pub_date: 2009-11-28
tags: [apple]
title: (One of) my problems(s) with MobileMe
summary: |
    Why Dropbox is better than MobileMe
---

{{ page.title }}
================

I currently use [Apple][0]'s [MobileMe][1] service to keep my iPhone and
Mac in sync. This I do slightly begrudgingly, but do so for the
following reasons:

[0]: http://www.apple.com/
[1]: http://www.me.com/

* The effort of setting up my own WebDAV server in order to keep my
  precious [OmniFocus][2] running across my phone and desktop is too much
  at the moment;
* I like having push calendar updates; and
* I like having push address book updates.

[2]: http://www.omnigroup.com/products/omnifocus/

My chief problem with MobileMe is that it just seems to be implemented
badly, which, as a professional developer, grates on me. It's very slow
over WebDAV (taking around 10s to sync a small SQLite database), and the
way files are shared over iDisk is just stupid: it creates a pre-sized
disk image (in my case 2GB) on your hard drive and then syncs that. What
if I had chosen to use the maximum 20GB size? I'd have a 20GB lump
(mostly empty) sitting on my hard drive, because the size is
pre-allocated.

[Dropbox][3] is a shining example of how to do file-sharing between
computers properly: it creates a folder in your home directory that just
takes up the room required by the files you've uploaded. Easy, works
seamlessly, and has a sweet iPhone application.

[3]: http://dropbox.com/

Increasingly, MobileMe is seeming like more of a hassle than is worth
the money: and it's quite a bit of money (£59.99 per year at time of
original publication).
