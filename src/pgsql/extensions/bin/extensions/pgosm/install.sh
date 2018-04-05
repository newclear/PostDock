#!/usr/bin/env bash

if [ "$EXTENSIONS_BATCH_INSTALL" = "" ]; then
  apt-get install -y make build-essential
fi
cd /tmp && \
    wget -qO-  https://github.com/openstreetmap/openstreetmap-website/archive/master.tar.gz | tar xz

cd /tmp/openstreetmap-website-master/db/functions 
make libpgosm.so 
cp libpgosm.so /usr/lib/postgresql/$PG_MAJOR/lib

if [ "$EXTENSIONS_BATCH_INSTALL" = "" ]; then
  apt-get remove -y make build-essential
fi
cd /
rm -rf /tmp/openstreetmap-website-master/
