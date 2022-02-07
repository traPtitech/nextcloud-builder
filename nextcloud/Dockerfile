ARG NEXTCLOUD_VERSION
ARG PHP_VERSION
FROM php:${PHP_VERSION}-alpine AS build

RUN apk add --no-cache libzip-dev gmp-dev git \
    && docker-php-ext-install zip gmp
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN git clone https://github.com/traPtitech/nc-trapauth.git /nc-trapauth

WORKDIR /nc-trapauth
RUN composer install

RUN git clone https://github.com/traPtitech/nc-traq-avatar /traq_avatar

WORKDIR /traq_avatar
RUN composer install

FROM nextcloud:${NEXTCLOUD_VERSION}

COPY --from=build /nc-trapauth /usr/src/nextcloud/custom_apps/nc-trapauth
COPY --from=build /traq_avatar /usr/src/nextcloud/custom_apps/traq_avatar

COPY config/* /usr/src/nextcloud/config/

COPY entrypoint_post.sh /entrypoint_post.sh
# 「exec "$@"」の前に「sh /entrypoint_post.sh」を挿入する
RUN sed -i -e '/^exec "\$@"/i sh /entrypoint_post.sh' /entrypoint.sh
