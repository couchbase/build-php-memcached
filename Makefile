all:
	./build-php-memcached.sh

clean:
	@rm -rf build downloads usr php-couchbase-memcached*

.PHONY: clean