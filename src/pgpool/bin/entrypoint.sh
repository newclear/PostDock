#!/usr/bin/env bash
set -e

if [ "$USE_ENV_SECRET" != "" -a -e /run/secrets/$USE_ENV_SECRET ]; then
  source <(sed -E -n 's/[^#]+/export &/ p' /run/secrets/$USE_ENV_SECRET)
fi

export CONFIG_FILE='/usr/local/etc/pgpool.conf'
export PCP_FILE='/usr/local/etc/pcp.conf'
export HBA_FILE='/usr/local/etc/pool_hba.conf'
export POOL_PASSWD_FILE='/usr/local/etc/pool_passwd'


echo '>>> STARTING SSH (if required)...'
source /home/postgres/.ssh/entrypoint.sh

echo '>>> TURNING PGPOOL...'
/usr/local/bin/pgpool/pgpool_setup.sh

echo '>>> STARTING PGPOOL...'
gosu postgres /usr/local/bin/pgpool/pgpool_start.sh
