FROM php:alpine AS build

ARG NEXTCLOUD_VERSION

RUN apk add --no-cache libzip-dev gmp-dev git \
    && docker-php-ext-install zip gmp
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN git clone https://github.com/traPtitech/nc-trapauth.git /nc-trapauth

WORKDIR /nc-trapauth
RUN composer install

ENV IMAGE=nextcloud:$NEXTCLOUD_VERSION-fpm

FROM $IMAGE

COPY --from=build /nc-trapauth /usr/src/nextcloud/apps/nc-trapauth
