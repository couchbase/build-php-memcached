# Couchbase driver for PHP

Contents:

  ./
  ./README.md       This file.
  ./memcached.so    The PHP extension as a shared library.


## Installation

Edit your `php.ini` to include this line:

    extension=memcached.so

To find where you `php.ini` file is, try `phpi -i | grep memcached` or look
at your `<?php phpinfo() ?>` output.


## Verify Installation

Run this test script:

    <?php
    $mc = new Memcached;
    $mc->addServer("localhost", 11211);
    $mc->set("a", 1);
    var_dump($mc->get("a"));

Make sure you have started your memcached, Membase or Couchbase server. Adjust
the hostname and port as needed.


## Support

If you have an questions, problems or suggestions, please let us know on the
Couchbase SDK forums:

http://www.couchbase.org/forums/sdks/sdks
