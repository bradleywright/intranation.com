# -*- mode: nginx -*-

# configuration and redirects from tumblr.intranation.com to intranation.com

server {
    listen 80;
    server_name tumblr.intranation.com;

    # no root, just redirects
    rewrite ^$ http://intranation.com/ permanent;
    rewrite ^/about$ http://intranation.com/about/ permanent;
    rewrite ^/rss$ http://intranation.com/feed permanent;
    rewrite ^/post/766290952/why-i-dont-use-virtualbox$ http://intranation.com/2010/03/why-i-dont-use-virtualbox/ permanent;
    rewrite ^/post/766290743/using-dropbox-git-repository$ http://intranation.com/2010/02/using-dropbox-git-repository/ permanent;
    rewrite ^/post/766290565/how-set-up-your-own-private-git-server-linux$ http://intranation.com/2010/01/how-set-up-your-own-private-git-server-linux/ permanent;
    rewrite ^/post/766290325/python-virtualenv-quickstart-django$ http://intranation.com/2009/12/python-virtualenv-quickstart-django/ permanent;
    rewrite ^/post/766289934/week-using-emacs$ http://intranation.com/2009/06/week-using-emacs/ permanent;
    rewrite ^/post/766289691/development-virtual-machines-os-x-using-vmware-ubuntu$ http://intranation.com/2009/03/development-virtual-machines-os-x-using-vmware-and/ permanent;
    rewrite ^/post/766289439/ubuntu-intrepid-ibex-and-vmware-fusion-tools$ http://intranation.com/2009/02/ubuntu-intrepid-ibex-and-vmware-fusion-tools/ permanent;
    rewrite ^/post/766289166/resolute$ http://intranation.com/2009/01/resolute/ permanent;
    rewrite ^/post/766288989/django-static-asset-management$ http://intranation.com/2008/11/django-static-asset-management/ permanent;
    rewrite ^/post/766288807/synchronising-things-using-dropbox$ http://intranation.com/2008/10/synchronising-things-using-dropbox/ permanent;
    rewrite ^/post/766288554/installing-django-osx$ http://intranation.com/2008/10/installing-django-osx/ permanent;
    rewrite ^/post/766288369/using-nginx-reverse-proxy$ http://intranation.com/2008/09/using-nginx-reverse-proxy/ permanent;
    rewrite ^/post/766288163/hiatus$ http://intranation.com/2008/09/hiatus/ permanent;
    rewrite ^/post/766287422/unacceptable-marketing-practices-carsonified$ http://intranation.com/2008/08/unacceptable-marketing-practices-carsonified/ permanent;
    rewrite ^/post/766287087/ie-and-buttons$ http://intranation.com/2008/08/ie-and-buttons/ permanent;
    rewrite ^/post/766283182/first-post$ http://intranation.com/2008/07/first-post/ permanent;
}
