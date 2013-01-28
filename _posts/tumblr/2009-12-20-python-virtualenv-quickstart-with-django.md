---
layout: post
title: Python virtualenv quickstart with Django
---

One of the solutions to the [ghetto of Python package
management](http://jessenoller.com/2009/07/17/trapped-in-python-package-send-
food/) is to use a sand-boxed Python install like
[virtualenv](http://pypi.python.org/pypi/virtualenv). This is the very same
technique we use at [Smarkets](http://smarkets.com/) to simultaneously run
[Pylons](http://pylonshq.com/) and [Django](http://djangoproject.com/)
alongside each other on a single server.

This post is briefly about how to get up and running in a few minutes using
virtualenv and Django.

## Install virtualenv

Installing virtualenv is easy on a Linux or Mac system, but the instructions
that follow are Linux (Ubuntu, actually) specific. First you'll need
setuptools:


    sudo apt-get install python-setuptools

Then we can easy_install virtualenv:


    sudo easy_install virtualenv

We need to use sudo here because it has to install to a global location. Don’t
worry, this is the last time we’ll need to do something as root.

## Create your virtualenv

`cd` to wherever it is you keep your projects (for me, in `~/src`), and run:


    virtualenv --no-site-packages venv

In this instance I’ve chosen venv as the name for my virtual environment. The
`--no-site-packages` command tells virtualenv not to symlink the global site
packages into my local environment, just take the Python standard library.
This is important, because it helps us avoid the dependency difficulties
mentioned above.

At this stage you might want to add venv to your list of ignored files, as you
don’t want it to be committed to source control:


    echo "venv" >> .gitignore

## Installing Django

Now, the trick with virtualenv is that it creates its own Python and
easy_install binaries, which means you can install/run things specifically in
your environment. Let’s install Django:


    ./venv/bin/easy_install django

And it’s done. easy. You might also want to install the MySQL bindings and
[IPython](http://ipython.scipy.org/moin/) for ease of use:


    ./venv/bin/easy_install ipython python-mysql

To start a new Django project, you’ll note that a django-admin.py file will
have been installed for you in the environment:


    ./venv/bin/django-admin.py startproject myapp

Obviously you can skip this step if you have an existing Django project.

## Running Django

Now the last step, which is probably obvious by now, is to run Django’s
runserver with the virtual Python binary:


    cd myapp
    ../venv/bin/python manage.py runserver 0.0.0.0:8000

And you’re away!

## Closing

Just make sure whenever you need to add another package that you install it in
the virtualenv, and not in the global packages directory. If you want to
deploy using virtualenv, here are [some instructions for using
mod_wsgi](http://code.google.com/p/modwsgi/wiki/VirtualEnvironments) with
virtualenvs.
