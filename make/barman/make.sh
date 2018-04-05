echo ">>> Making barman"

for VALS in "BARMAN_VERSION=2.3 BARMAN_PACKAGE_VERSION=2.3-2"; do
    eval $VALS

    for PG_CLIENT_VERSION in 9.6 10; do
        if [[ "$PG_CLIENT_VERSION" = "10" ]];then 
          DEBIAN_VERSION="stretch"
          PACKAGE_VERSION_SUFFIX=".pgdg90+1"
        else
          DEBIAN_VERSION="jessie"
          PACKAGE_VERSION_SUFFIX=".pgdg80+1"
        fi
        BARMAN_PACKAGE_VERSION_FULL="$BARMAN_PACKAGE_VERSION$PACKAGE_VERSION_SUFFIX"
        VALS="BARMAN_VERSION=$BARMAN_VERSION BARMAN_PACKAGE_VERSION=$BARMAN_PACKAGE_VERSION_FULL PG_CLIENT_VERSION=$PG_CLIENT_VERSION PG_CLIENT_LATEST=1 DEBIAN_VERSION=$DEBIAN_VERSION"
        FILE_FROM="./src/includes/dockerfile/Barman-$BARMAN_VERSION.part.Dockerfile"
        FILE_TO="./src/Barman-$BARMAN_VERSION-Postgres-$PG_CLIENT_VERSION.Dockerfile"
        
        template $FILE_FROM $FILE_TO $VALS
    done
done
