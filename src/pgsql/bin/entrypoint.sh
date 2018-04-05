#!/usr/bin/env bash
set -e

echo ">>> Setting up STOP handlers..."
for f in TERM SIGTERM QUIT SIGQUIT INT SIGINT KILL SIGKILL; do
    trap "system_stop $f" "$f"
done

if [ "$USE_ENV_SECRET" != "" -a -e /run/secrets/$USE_ENV_SECRET ]; then
  source <(sed -E -n 's/[^#]+/export &/ p' /run/secrets/$USE_ENV_SECRET)
fi

echo '>>> STARTING SSH (if required)...'
source /home/postgres/.ssh/entrypoint.sh

echo '>>> STARTING POSTGRES...'
/usr/local/bin/cluster/postgres/entrypoint.sh & wait ${!} || echo ">>> Foreground processes returned code: '$?'"

while [ -f /var/run/recovery.lock ]; do
    sleep 1;
done;

system_exit
