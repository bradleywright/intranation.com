---
layout: base
pub_date: 2008-09-28
tags: [development, django, nginx, sysadmin]
title: Using Nginx as a reverse proxy
summary: |
    How to use the Nginx web server as a proxy frontend to Django or other
    application servers.
---

{{ page.title }}
================

It’s common knowledge that when you’re serving a web application you
shouldn’t use a standard Apache install to serve static assets, as it
comes with too much overhead. I won’t go into the details of *why*
here, as it’s been covered by many other people
[better qualified than I][0].

[0]: http://www.thinkvitamin.com/features/webapps/serving-javascript-fast

What I can do, however, is tell you how I set up [Nginx][1], which is
a super light–weight web server, on my VPS here on [Slicehost][2] (who
are awesome, by the way).

[1]: http://nginx.net/
[2]: http://www.slicehost.com/

## Quick theory

Just quickly, the theory is that Nginx listens on port 80, and
subsequently sends requests for certain URL patterns through to the
mod_wsgi server (in my case, Apache) listening on a different
port. This server currently serves the meat of my [Django][3]
site. Static assets (<abbr title="JavaScript">JS</abbr>, <abbr
title="Cascading Style Sheets">CSS</abbr>, images) are served directly
from Nginx without ever touching Apache.

[3]: http://www.djangoproject.com/

## Assumptions

We assume several things for this article:

* You’re comfortable with a command line;
* You’re using Ubuntu or Debian (I use ``apt-get`` quite a lot);
* You have ``sudo`` access to a server; and
* You’re already serving Django or similar on Apache and just want to
  replace the static/front-end.

## First server

Firstly you’ll need the basic tools to install Nginx:

{% highlight console %}
sudo apt-get install libpcre3 libpcre3-dev libpcrecpp0 \
libssl-dev zlib1g-dev make
{% endhighlight %}

What we’re installing here is the minimum amount of tools needed to
run GZip and URL re–writing with Nginx.

### Get Nginx

At the time of writing, the latest stable version of Nginx was 0.6.32,
so let’s get that. Note that we need full source code as the version
that ships with Ubuntu and Debian is 0.5.3 or similar, which doesn’t
have URL rewriting or GZip compression (both of which I really want).

{% highlight console %}
mkdir ~/src
cd !$
wget http://sysoev.ru/nginx/nginx-0.6.32.tar.gz
tar -zxvf nginx-0.6.32.tar.gz
cd nginx-0.6.32
{% endhighlight %}

So we downloaded the source, de–compressed it, and went into the
directory that was created.

### Compile Nginx

We have a few different options to run here, most of which are
personal taste. Feel free to modify as required:

{% highlight console %}
./configure --pid-path=/var/run/nginx.pid \
--conf-path=/etc/nginx/nginx.conf --sbin-path=/usr/local/sbin \
--with-http_ssl_module --user=www-data --group=www-data \
--http-log-path=/var/log/nginx/access.log \
--error-log-path=/var/log/nginx/error.log
{% endhighlight %}

The only thing I would say should be kept there is the PID file path
and the user/group configuration. The user/group matches the accounts
that Apache uses, so it keeps everything under the same user
structure. If you want to use a different user account, be sure to
create this user before running `./configure`.

The above command will spit out a set of paths for your convenience:
these should look similar to the following:

{% highlight console %}
nginx path prefix: "/usr/local/nginx"
nginx binary file: "/usr/local/sbin"
nginx configuration prefix: "/etc/nginx"
nginx configuration file: "/etc/nginx/nginx.conf"
nginx pid file: "/var/run/nginx.pid"
nginx error log file: "/usr/local/nginx/logs/error.log"
nginx http access log file: "/usr/local/nginx/logs/access.log"
nginx http client request body temporary files: "/usr/local/nginx/client_body_temp"
nginx http proxy temporary files: "/usr/local/nginx/proxy_temp"
nginx http fastcgi temporary files: "/usr/local/nginx/fastcgi_temp"
{% endhighlight %}

You may want to copy them somewhere for posterity.

Nginx will now have started, but won’t be running because Apache is
using port 80, and Nginx is very helpful and fails silently.

## Swap Apache and Nginx

First we need to stop Apache:

{% highlight console %}
sudo apache2ctl stop
{% endhighlight %}

Then we start Nginx:

{% highlight console %}
sudo /usr/local/bin/nginx
{% endhighlight %}

Note that the path to ``nginx`` will be different depending on what
value (if any) you used in the ``./configure`` stage.

If you now navigate to your IP address, you should see a “Welcome to
Nginx!” message. Great!

### Make Apache listen on a different port

I chose port 8080, since that seemed sensible and symmetrical.

{% highlight console %}
sudo vi /etc/apache2/ports.conf
{% endhighlight %}

And change the value to something you can remember.

{% highlight console %}
sudo apache2ctl start
{% endhighlight %}

And navigate to your old site but with `8080` appended to the IP
address. You should see your old site there. (**Note**: I’ve added <a
href="#update">extra information about Apache</a> at the end of this
article).

### Configure Nginx

Nginx comes with some initial configuration, but here’s what I use:

{% highlight nginx %}
  user                www-data www-data;
  worker_processes    2;

  error_log           /var/log/nginx/error.log warn;
  pid                 /var/run/nginx.pid;

  events {
      worker_connections  1024;
      use epoll;
  }

  http {
      # allow long server names
      server_names_hash_bucket_size 64;

      include             /etc/nginx/mime.types;
      default_type        application/octet-stream;

      log_format main '$remote_addr - $remote_user [$time_local] '
                      '"$request" $status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

      access_log          /var/log/nginx/access.log;

      # spool uploads to disk instead of clobbering downstream servers
      client_body_temp_path /var/spool/nginx-client-body 1 2;
      client_max_body_size 32m;
      client_body_buffer_size    128k;

      server_tokens       off;

      sendfile            on;
      tcp_nopush          on;
      tcp_nodelay         off;

      keepalive_timeout   5;

      ## Compression
      gzip on;
      gzip_http_version 1.0;
      gzip_comp_level 2;
      gzip_proxied any;
      gzip_min_length  1100;
      gzip_buffers 16 8k;
      gzip_types text/plain text/html text/css application/x-javascript \
          text/xml application/xml application/xml+rss text/javascript;
      # Some version of IE 6 don't handle compression well on some mime-types,
      # so just disable for them
      gzip_disable "MSIE [1-6].(?!.*SV1)";
      # Set a vary header so downstream proxies don't send cached gzipped
      # content to IE6
      gzip_vary on;

      # proxy settings
      proxy_redirect     off;

      proxy_set_header   Host             $host;
      proxy_set_header   X-Real-IP        $remote_addr;
      proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
      proxy_max_temp_file_size 0;

      proxy_connect_timeout      90;
      proxy_send_timeout         90;
      proxy_read_timeout         90;

      proxy_buffer_size          4k;
      proxy_buffers              4 32k;
      proxy_busy_buffers_size    64k;
      proxy_temp_file_write_size 64k;

      include             /etc/nginx/sites-enabled/*;
  }
{% endhighlight %}

Note that this is the primary configuration, which if you’d followed
the above installation verbatim would be at `/etc/nginx/nginx.conf`.

To test that this configuration works, we add a simple localhost
configuration file:

{% highlight console %}
sudo mkdir /etc/nginx/sites-enabled
sudo vi /etc/nginx/sites-enabled/localhost.conf
{% endhighlight %}

And put the following configuration into it:

{% highlight nginx %}
server {
    listen       80;
    server_name  localhost;

    location / {
        root   html;
        index  index.html index.htm;
    }
}
{% endhighlight %}

### Proxy requests to Apache

Now we need to send requests to Apache. This is actually very simple:

{% highlight console %}
sudo vi /etc/nginx/sites-enabled/testproject.conf
{% endhighlight %}

We’re pretending that your domain is at `testproject.com` for the purposes of this exercise.

Enter the following into your domain config:

{% highlight nginx %}

  # primary server - proxypass to Django
  server {
      listen       80;
      server_name  dev.testproject.com;

      access_log  off;
      error_log off;

      # proxy to Apache 2 and mod_python
      location / {
          proxy_pass         http://127.0.0.1:8080/;
          proxy_redirect     off;

          proxy_set_header   Host             $host;
          proxy_set_header   X-Real-IP        $remote_addr;
          proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
          proxy_max_temp_file_size 0;

          client_max_body_size       10m;
          client_body_buffer_size    128k;

          proxy_connect_timeout      90;
          proxy_send_timeout         90;
          proxy_read_timeout         90;

          proxy_buffer_size          4k;
          proxy_buffers              4 32k;
          proxy_busy_buffers_size    64k;
          proxy_temp_file_write_size 64k;
      }
  }

{% endhighlight %}

Again, the IP address and locations of configuration files depend on
whether you changed anything during the process so far.

### That’s it!

When you next start Nginx, it should send all requests through to
Apache on port 8080, and your memory overhead should start coming
down.

## What next?

In the next instalment we’re going to set up Nginx as a static content
server, in order to bypass Apache completely for anything non–dynamic.

Enjoy!

## Additional reading

This article is based on the hard work of those awesome people over at
[Slicehost][4], and my experience on their servers.

[4]: http://www.slicehost.com/

* [Installing Nginx from source](http://articles.slicehost.com/2007/12/3/ubuntu-gutsy-installing-nginx-from-source)
* [A better way of stopping and starting Nginx](http://articles.slicehost.com/2007/12/3/ubuntu-gutsy-adding-an-nginx-init-script)

## Update

[Gareth Rushgrove][5] mentioned to me at [work][6] that if you’re not
exposing Apache to the world on port 80, you probably shouldn’t let it
listen to any interface except loopback (otherwise people can see your
dynamic site on `http://yourdomain.com:8080`). This isn’t an
issue for me because I firewall almost every port except 80, but in
case you’re interested here’s how to configure Apache:

[5]: http://morethanseven.net/
[6]: http://thisisglobal.com/

{% highlight console %}
sudo vim /etc/apache2/ports.conf
{% endhighlight %}

And add `127.0.0.1:` before the port number you’re using for your
Apache, for example:

{% highlight nginx %}
Listen 127.0.0.1:8080
{% endhighlight %}

Now restart Apache and you should be secure that only Nginx is
receiving HTTP requests from the outside world (or “The Internets”, as
we in the industry call it).

To check what interfaces *are* listening, period, use this command:

{% highlight console %}
netstat -pant
{% endhighlight %}
