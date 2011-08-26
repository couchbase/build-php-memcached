#!/bin/sh -ex

NAME=distro
BUILDDIR=build-distro
rm -rf $BUILDDIR
mkdir $BUILDDIR
cd $BUILDDIR
  rm -rf $NAME
  mkdir $NAME
  cd $NAME
    repo init -u https://github.com/couchbase/php-memcached-manifest --mirror
    repo init -u https://github.com/couchbase/php-memcached-manifest --depth=1 # don't ask
    repo sync
  cd ..
  tar -czf $NAME.tgz $NAME
cd ..
echo "$NAME.tgz done"
