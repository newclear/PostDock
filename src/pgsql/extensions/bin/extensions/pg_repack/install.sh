#!/usr/bin/env bash

if [ "$EXTENSIONS_BATCH_INSTALL" = "" ]; then
  apt-get install -y make unzip gcc libssl-dev zlib1g-dev
fi
wget -q -O pg_repack.zip "https://api.pgxn.org/dist/pg_repack/1.4.2/pg_repack-1.4.2.zip"
unzip pg_repack.zip && rm pg_repack.zip
cd pg_repack-*
make && make install
cd ..
rm -rf pg_repack-*
if [ "$EXTENSIONS_BATCH_INSTALL" = "" ]; then
  apt-get remove --auto-remove -y make unzip gcc libssl-dev zlib1g-dev
fi
