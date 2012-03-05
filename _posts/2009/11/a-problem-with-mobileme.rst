public: yes
pub_date: 2009-11-28
tags: [apple]
summary: |
    Why Dropbox is better than MobileMe

=======================================
  (One of) My Problems(s) with MobileMe
=======================================

I currently use `Apple`__’s `MobileMe`__ service to keep my iPhone and
Mac in sync. This I do slightly begrudgingly, but do so for the
following reasons:

__ http://www.apple.com/
__ http://www.me.com/

* The effort of setting up my own WebDAV server in order to keep my
  precious `OmniFocus`__ running across my phone and desktop is too much
  at the moment;
* I like having push calendar updates; and
* I like having push address book updates.

__ http://www.omnigroup.com/products/omnifocus/

My chief problem with MobileMe is that it just seems to be implemented
badly, which, as a professional developer, grates on me. It's very slow
over WebDAV (taking around 10s to sync a small SQLite database), and the
way files are shared over iDisk is just stupid: it creates a pre–sized
disk image (in my case 2GB) on your hard drive and then syncs that. What
if I had chosen to use the maximum 20GB size? I'd have a 20GB lump
(mostly empty) sitting on my hard drive, because the size is
pre–allocated.

`Dropbox`__ is a shining example of how to do file–sharing between
computers properly: it creates a folder in your home directory that just
takes up the room required by the files you’ve uploaded. Easy, works
seamlessly, and has a sweet iPhone application.

__ http://dropbox.com/

Increasingly, MobileMe is seeming like more of a hassle than is worth
the money: and it’s quite a bit of money (£59.99 per year at time of
original publication).
