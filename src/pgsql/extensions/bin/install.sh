#!/usr/bin/env bash
set -x
set -e

EXTENSIONS="$1"
apt-get update
echo "> Will install extensions: $EXTENSIONS"
dir=$(pwd)
export EXTENSIONS_BATCH_INSTALL=1
apt-get install -y --no-install-recommends make unzip gcc libssl-dev zlib1g-dev build-essential
for EXTENSION in $EXTENSIONS;
do
    echo ">>> Installing now $EXTENSION"
    source /extensions_installer/extensions/$EXTENSION/install.sh
    cd $dir
done
apt-get remove --auto-remove -y make unzip gcc libssl-dev zlib1g-dev build-essential
apt-get clean
