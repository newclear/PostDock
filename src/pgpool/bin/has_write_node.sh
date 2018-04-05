#!/usr/bin/env bash

if [ "$USE_ENV_SECRET" != "" -a -e /run/secrets/$USE_ENV_SECRET ]; then
  source <(sed -E -n 's/[^#]+/export &/ p' /run/secrets/$USE_ENV_SECRET)
fi

PRIMARY_COUNT=$(PGCONNECT_TIMEOUT=$CHECK_PGCONNECT_TIMEOUT PGPASSWORD=$CHECK_PASSWORD psql -U $CHECK_USER -h 127.0.0.1 template1 -c 'show pool_nodes' | grep primary | wc -l)

if [[ "$PRIMARY_COUNT" == "0" ]]; then
    exit 1
else
    exit 0
fi
