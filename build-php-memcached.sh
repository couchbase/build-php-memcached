#!/bin/sh -ex

if [ ! -d libmemcached -o ! -d php-memcached ]; then
  echo "Forgot repo sync?"
  exit 1
fi

rm -rf usr
mkdir -p usr

cd libmemcached
  ./config/autorun.sh
  ./configure --disable-shared --enable-static --prefix=`pwd`/../usr
  make
  make test
  make install
cd .. 

cd php-memcached
  phpize
  ./configure --with-libmemcached-dir=`pwd`/../usr/
  make
  PIDFILE=/tmp/mc$$.pid
  memcached -P $PIDFILE -d
  NO_INTERACTION=true make test
  kill `cat $PIDFILE`
  rm $PIDFILE
cd ..

# package
cp php-memcached/.libs/memcached.so php-couchbase-memcached/
tar czf php-couchbase-memcached.tar.gz php-couchbase-memcached

echo "Done, created php-couchbase-memcached.tar.gz"

# Done