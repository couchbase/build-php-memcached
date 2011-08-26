#!/bin/sh -ex

NAME=php-couchbase-memcached-source
rm -rf $NAME
mkdir $NAME
cd $NAME
  FILES="../Makefile \
         ../build-distro \
         ../build-php-memcached \
         ../build-php-memcached.sh \
         ../build-source-package.sh \
         ../libmemcached \
         ../php-couchbase \
         ../php-memcached"
  cp -r $FILES .
cd ..
tar -czf $NAME.tgz $NAME

echo "$NAME.tgz done"
