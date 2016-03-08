#!/bin/sh

# start php-fpm
php-fpm

# start nginx
mkdir -p /tmp/nginx
chown nginx /tmp/nginx
nginx
