#!/bin/sh
# Fix Snowflake argument order.
set -eu

file=/usr/src/nextcloud/lib/private/Snowflake/SnowflakeGenerator.php
[ -f "$file" ] || exit 0

if grep -Fq '$this->sequenceGenerator->nextId($seconds, $milliseconds, $serverId)' "$file"; then
    sed -i 's/\$this->sequenceGenerator->nextId(\$seconds, \$milliseconds, \$serverId)/$this->sequenceGenerator->nextId($serverId, $seconds, $milliseconds)/' "$file"
else
    [ "$?" -eq 1 ]
fi
