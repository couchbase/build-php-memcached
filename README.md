# Builds php-memcached

Currently hardcoded, this links libmemcached statically to make deployments easy.

Start the build with:

    $ make

You will see a lot of build and test suite output, do not worry, this takes a while due to libmemcached's `make test` not being very fast.

If all is well, you will see at the end:

> Done, created php-couchbase-memcached.tar.gz

The .tar.gz will include a file `memcached.so` that is a PHP extension.

Install it by adding this to your `php.ini`:

    extension=/path/to/memcache.so

Now your php should have memcached support enabled and you should see something like this:

    $ php -i | grep memcached
    memcached
    memcached support => enabled
    libmemcached version => 0.43
    memcached.compression_factor => 1.3 => 1.3
    memcached.compression_threshold => 2000 => 2000
    memcached.compression_type => fastlz => fastlz
    memcached.serializer => php => php
    memcached.sess_lock_wait => 150000 => 150000
    memcached.sess_locking => 1 => 1
    memcached.sess_prefix => memc.sess.key. => memc.sess.key.
    memcached.use_sasl => 0 => 0
    Registered save handlers => files user sqlite memcached 

Or a corresponding section in your `<?php phpinfo(); ?>` output.

## Dependencies

 - GNU Autotools, build essentials
 - php and php-devel packages
 - all other dependencies of libmemcached.

