ARG NEXTCLOUD_VERSION
FROM php:${PHP_VERSION}alpine AS build

RUN apk add --no-cache libzip-dev gmp-dev git \
    && docker-php-ext-install zip gmp
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN git clone https://github.com/traPtitech/nc-trapauth.git /nc-trapauth

WORKDIR /nc-trapauth
RUN composer install

RUN git clone https://github.com/traPtitech/nc-traq-avatar /traq_avatar

WORKDIR /traq_avatar
RUN composer install

FROM nextcloud:${NEXTCLOUD_VERSION}-fpm

COPY --from=build /nc-trapauth /usr/src/nextcloud/apps/nc-trapauth
COPY --from=build /traq_avatar /usr/src/nextcloud/apps/traq_avatar
