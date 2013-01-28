---
layout: post
title: Using Dropbox as a Git repository
tags:
- git
- development
---
So last month [I wrote a bit about setting up your own personal Git
repositories on a Linux box](http://intranation.com/entries/2010/01/how-set-
up-your-own-private-git-server-linux/), and how to use that for sharing code.

I’ve had a slight epiphany since then: what if I just used the awesome
[Dropbox](http://dropbox.com) ([my referral
link](https://www.dropbox.com/referrals/NTE5NjgwOQ), if you’re likely to sign
up) to share Git repositories between computers? Dropbox seems able to get
through most corporate firewalls (my [previous
employer](http://thisisglobal.com) blocked SSH, for example), and is very
unobtrusive in its synchronisation behaviour.

## Enough introductions, make with the commands

Okay, here we go. Basically, we’re just going add a new `remote` which points
at Dropbox (in the same way the `origin` remote typically points at your
primary external repository). Please note these instructions should be mostly
`*Nix` agnostic—but they’re only tested on [OS X](http://www.apple.com/macosx/).

First, create the Git repository in Dropbox (assuming your repository is named
myrepo):


    cd ~/Dropbox
    mkdir -p repos/myrepo.git
    cd !$
    git --bare init

And that’s the repository created. Basically we made a bare repository in the
Dropbox directory.

Now we can add the new `remote` to our existing repository (again, assuming it
lives at ~/Projects/myrepo).


    cd ~/Projects/myrepo
    git remote add dropbox file://$HOME/Dropbox/repos/myrepo.git
    git push dropbox master

And we’re done. We’ve created the repository, linked a Git remote to it, and
pushed the master branch to the repository. This Git repository will now be
available on all computers that your Dropbox account is.

## Pulling from the repository

When you get to a computer that shares this Dropbox account, but hasn’t
checked out Git yet, do as follows:


    cd ~/Projects
    git clone -o dropbox file://$HOME/Dropbox/repos/myrepo.git

Which will add your repository locally, and automatically set up a remote
called dropbox which auto–merges with master.

I think this approach could be valuable for things like keeping personal
documents or text files in version control (or indeed personal coding
projects) without bothering to set up your own Linux box or server. Git really
does make these things incredibly easy.
