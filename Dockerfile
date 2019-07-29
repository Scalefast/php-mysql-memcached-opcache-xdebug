FROM php:7.0-fpm-alpine

# Installs XDebug extension and enables it
RUN apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug-2.5.0 \
    && docker-php-ext-enable xdebug

# Installs MySQL & OPCache extensions and enable them
RUN docker-php-ext-install mysqli \
    && docker-php-ext-install opcache \
    && docker-php-ext-enable mysqli \
    && docker-php-ext-enable opcache

# Installs Memcached extension and enables it
RUN curl -L -o /tmp/memcached.tar.gz "https://github.com/php-memcached-dev/php-memcached/archive/v3.1.3.tar.gz" \
    && mkdir -p /usr/src/php/ext/memcached \
    && tar -C /usr/src/php/ext/memcached -zxvf /tmp/memcached.tar.gz --strip 1 \
    && apk add --no-cache zlib-dev libmemcached-dev \
    && docker-php-ext-configure memcached \
    && docker-php-ext-install memcached \
    && rm /tmp/memcached.tar.gz
