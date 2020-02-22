FROM php:alpine AS build

RUN apk add --no-cache libzip-dev gmp-dev git \
    && docker-php-ext-install zip gmp
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN git clone https://github.com/traPtitech/nc-trapauth.git /nc-trapauth

WORKDIR /nc-trapauth
RUN composer install

FROM nextcloud:18-fpm

COPY --from=build /nc-trapauth /usr/src/nextcloud/apps/nc-trapauth
