all:
	./build-php-memcached.sh

source:
	./build-source-package.sh

clean:
	rm -rf build downloads usr php-couchbase-memcached*

.PHONY: clean source