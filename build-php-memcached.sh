#!/bin/sh -ex

# config
LIBMEMCACHED_VERSION=0.43

# end config

# clean previous run
rm -rf downloads \
  build usr php-couchbase-memcached php-couchbase-memcached.tar.gz

# setup 
mkdir -p downloads
mkdir -p build
mkdir -p usr
mkdir -p php-couchbase-memcached

UNAME=`uname`
WGET="wget"
if [ "$UNAME" == "Darwin" ]; then # mac compat
  WGET="curl -O"
fi


# libmemcached
LIBMEMCACHED_DIR=libmemcached-$LIBMEMCACHED_VERSION
LIBMEMCACHED_FILE=$LIBMEMCACHED_DIR.tar.gz
# download
LIBMEMCACHED_URL=http://download.tangent.org/$LIBMEMCACHED_FILE

cd downloads
  $WGET $LIBMEMCACHED_URL
cd ..

# build

cd build
  tar xzf ../downloads/$LIBMEMCACHED_FILE
  cd $LIBMEMCACHED_DIR
    ./configure --disable-shared --enable-static --prefix=`pwd`/../../usr
    make
    make test
    make install
  cd ..
cd .. 

# php-memcached
# download
PHP_MEMCACHED_URL=https://github.com/php-memcached-dev/php-memcached.git

cd downloads
  git clone $PHP_MEMCACHED_URL
cd ..

# build
cd build
  cp -r ../downloads/php-memcached .
  cd php-memcached
    phpize
    ./configure --with-libmemcached-dir=`pwd`/../../usr/ 
    make
    PIDFILE=/tmp/mc$$.pid
    memcached -P $PIDFILE -d
    NO_INTERACTION=true make test
    kill `cat $PIDFILE`
    rm $PIDFILE
  cd ..
cd ..

# package
cp build/php-memcached/.libs/memcached.so php-couchbase-memcached/
tar czf php-couchbase-memcached.tar.gz php-couchbase-memcached

echo ""
echo "Done, created php-couchbase-memcached.tar.gz"

# Done
