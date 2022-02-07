#!/bin/sh
set -eu

# https://github.com/nextcloud/docker/blob/dcf058fb559e7918cd77f5f1bb0dfdbcee813571/23/fpm/entrypoint.sh#L9-L12
# return true if specified directory is empty
directory_empty() {
    [ -z "$(ls -A "$1/")" ]
}

# https://github.com/nextcloud/docker/blob/dcf058fb559e7918cd77f5f1bb0dfdbcee813571/23/fpm/entrypoint.sh#L99-L103
if [ "$(id -u)" = 0 ]; then
    rsync_options="-rlDog --chown www-data:root"
else
    rsync_options="-rlD"
fi

# https://github.com/nextcloud/docker/blob/dcf058fb559e7918cd77f5f1bb0dfdbcee813571/23/fpm/entrypoint.sh#L106-L110
for dir in config custom_apps themes; do
    if [ ! -d "/var/www/html/$dir" ] || directory_empty "/var/www/html/$dir"; then
        rsync $rsync_options --include "/$dir/" --exclude '/*' /usr/src/nextcloud/ /var/www/html/
    fi
done
echo Copied config, custom_apps, themes
