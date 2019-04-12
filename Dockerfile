FROM php:7.2-fpm-alpine

COPY ./src .

#install git
# RUN apk add --no-cache git

# install mongodb extension
RUN pear config-set http_proxy http://153.96.12.26:80

RUN apk --update add gcc make g++ zlib-dev
RUN apk add --no-cache --update --virtual buildDeps autoconf \
 && pecl install mongodb \
 && docker-php-ext-enable mongodb \
 && apk del buildDeps

# run composer install
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install
