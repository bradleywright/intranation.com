public: yes
pub_date: 2010-10-18
tags: [development, virtualisation]
summary: |
    Fixing a bug in VMWare Fusion 3's mount settings.

===================================================
  Issues mounting shared folders in VMWare Fusion 3
===================================================

I recently took advantage of the `VMWare 3 upgrade for only $9.99
USD`__, which has all gone well, except for one issue with
<code>/etc/fstab</code>: it turns out that VMWare Fusion 3 tools doesn't
actually respect your mount settings, which means you lose all the
permissions information contained therein.

__ http://www.vmware.com/vmwarestore/fusion_upgrade_promo.html

There's `a solution to the mount problem here`__, which works perfectly
after a reboot. I hope VMWare fixes this soon, though: it's a pretty
nasty bug.

__ http://dmoonc.com/blog/?p=288
