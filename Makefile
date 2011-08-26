all:
	./build-php-memcached.sh

source:
	./build-source-package.php

clean:
	rm -rf build downloads usr php-couchbase-memcached*

.PHONY: clean source