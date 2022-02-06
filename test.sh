#!/bin/bash

set -eu

cd `dirname $0`

export NEXTCLOUD_VERSION="$(cat ./nextcloud/nextcloud_version)"
export PHP_VERSION="$(cat ./nextcloud/php_version)"

docker-compose up --build
