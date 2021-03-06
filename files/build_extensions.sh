#!/bin/sh
apk add alpine-sdk php-dev autoconf zlib-dev pcre-dev

pecl_install ()
{
  local EXT_TYPE=$1
  local NAME=$2
  local VERSION=$3
  local CONFIGURE_ARGS=$(shift 3; echo $@)
  local PECL_URL="https://pecl.php.net/get/$NAME-$VERSION.tgz"

  cd /tmp
  curl $PECL_URL -O
  tar xzf $NAME-$VERSION.tgz
  cd /tmp/$NAME-$VERSION
  phpize
  ./configure $CONFIGURE_ARGS
  make
  make install
  echo "$EXT_TYPE=$NAME.so" >> /etc/php/conf.d/$NAME.ini
}

# Install PHP extensions
pecl_install extension apcu 4.0.10 --enable-apcu
#pecl_install zend_extension xdebug 2.3.3 --enable-xdebug

# Cleanup
rm -rf /tmp/*
apk del autoconf php-dev zlib-dev pcre-dev alpine-sdk
rm -rf /var/cache/apk/*
