FROM php:alpine AS builder

RUN apk add --no-cache libzip-dev gmp-dev git \
    && docker-php-ext-install zip gmp
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN git clone git@github.com:traPtitech/nc-trapauth.git /

WORKDIR /nc-trapauth
RUN composer install

FROM nextcloud:fpm

COPY --from=build /nc-trapauth /var/www/html/apps/nc-trapauth
