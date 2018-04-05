echo ">>> Making pgpool"

for VALS in "PGPOOL_VERSION=3.3 PGPOOL_PACKAGE_VERSION=3.3.4-1" \
            "PGPOOL_VERSION=3.6 PGPOOL_PACKAGE_VERSION=3.6.7-1" \
            "PGPOOL_VERSION=3.7 PGPOOL_LATEST=1";  do
    eval $VALS
    
    for PG_CLIENT_VERSION in 9.6 10; do
        if [[ "$PG_CLIENT_VERSION" = "10" ]];then 
          DEBIAN_VERSION="stretch"
          PACKAGE_VERSION_SUFFIX=".pgdg90+1"
        else
          DEBIAN_VERSION="jessie"
          PACKAGE_VERSION_SUFFIX=".pgdg80+1"
        fi
        if [[ "$PGPOOL_VERSION" = "3.3" ]]; then
          PACKAGE_VERSION_SUFFIX=".pgdg70+1"
        fi
        if [[ "$PGPOOL_PACKAGE_VERSION" != "" ]]; then
          VALS="PGPOOL_VERSION=$PGPOOL_VERSION PGPOOL_PACKAGE_VERSION=$PGPOOL_PACKAGE_VERSION$PACKAGE_VERSION_SUFFIX"
        fi
        VALS="$VALS PG_CLIENT_VERSION=$PG_CLIENT_VERSION PG_CLIENT_LATEST=1 DEBIAN_VERSION=$DEBIAN_VERSION"

        FILE_FROM="./src/includes/dockerfile/Pgpool-$PGPOOL_VERSION.part.Dockerfile"
        FILE_TO="./src/Pgpool-$PGPOOL_VERSION-Postgres-$PG_CLIENT_VERSION.Dockerfile"
        
        template $FILE_FROM $FILE_TO $VALS
    done
done
