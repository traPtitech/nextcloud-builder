FROM php:alpine AS builder

RUN apk add --no-cache libzip-dev gmp-dev git \
    && docker-php-ext-install zip gmp
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN git clone git@github.com:traPtitech/nc-trapauth.git /apps/nc-trapauth

WORKDIR /apps/nc-trapauth
RUN composer install

FROM nextcloud:fpm

COPY --from=build /apps/nc-trapauth /var/www/html/apps/nc-trapauth
