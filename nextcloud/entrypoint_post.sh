#!/bin/sh
set -eu

# https://github.com/nextcloud/docker/blob/dcf058fb559e7918cd77f5f1bb0dfdbcee813571/23/fpm/entrypoint.sh#L99-L103
if [ "$(id -u)" = 0 ]; then
    rsync_options="-rlDog --chown www-data:root"
else
    rsync_options="-rlD"
fi

# https://github.com/nextcloud/docker/blob/dcf058fb559e7918cd77f5f1bb0dfdbcee813571/23/fpm/entrypoint.sh#L106-L110
for dir in custom_apps; do
    rsync $rsync_options --include "/$dir/" --exclude '/*' /usr/src/nextcloud/ /var/www/html/
done
echo Synced custom_apps
