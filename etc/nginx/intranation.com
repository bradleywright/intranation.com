# -*- mode: conf; -*-

# rewrite www. to non-www
server {
    listen              80;
    server_name         www.intranation.com;
    rewrite             ^/(.*) http://intranation.com/$1 permanent;
}

# the main server
server {
    listen              80;
    server_name         intranation.com;

    # redirects
    include intranation-tumblr-redirects.conf;

    # these variables are defined in a main file that includes this one
    root                $intranation_root;

    if ($intranation_access_log) {
       access_log       $intranation_access_log;
    }

    if ($intranation_error_log) {
       error_log        $intranation_error_log;
    }

    # cache the favicon
    location /favicon.ico {
        access_log        off;
        expires           30d;
    }
    location /robots.txt {
        access_log        off;
    }
}