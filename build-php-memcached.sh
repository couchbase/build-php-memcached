#!/bin/sh -ex

if [ ! -d libmemcached -o ! -d php-memcached ]; then
  echo "Forgot repo sync?"
  exit 1
fi

rm -rf usr php-couchbase-memcached
mkdir -p usr
mkdir -p php-couchbase-memcached

cd libmemcached
  ./config/autorun.sh
  CFLAGS=-fPIC ./configure --disable-shared --enable-static --disable-sasl \
    --prefix=`pwd`/../usr \
    $EXTRA_LIBMEMCACHED_CONFIGURE
  make
  make test
  make install
cd ..

cd php-memcached
  phpize
  ./configure --with-libmemcached-dir=`pwd`/../usr/ --disable-memcached-sasl
  make
  PIDFILE=/tmp/mc$$.pid
  memcached -P $PIDFILE -d
  NO_INTERACTION=true make test
  kill `cat $PIDFILE`
  rm $PIDFILE
cd ..

# test
PHP=`which php`
PHP_CMD="$PHP -d extension=php-memcached/.libs/memcached.so -i"
PHP_RESULT=`$PHP_CMD| grep 'memcached support => enabled'`
if [ -z "$PHP_RESULT" ]; then
  echo "Can't load memcached extension, exiting."
  exit 1;
fi

# package
cp php-memcached/.libs/memcached.so php-couchbase-memcached/
cp build-php-memcached/README.md php-couchbase-memcached/
tar czf php-couchbase-memcached.tar.gz php-couchbase-memcached

# cleanup
cd libmemcached
  make clean
cd ..

cd php-memcached
  make clean
cd ..

echo "Done, created php-couchbase-memcached.tar.gz"

# Done
