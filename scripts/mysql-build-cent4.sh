#!/bin/sh

set -e

PATH=/usr/bin:/sbin:/usr/sbin:/usr/local/bin:$PATH

BUILD_PATH=/home/vagrant/mysql-build
MYSQL_PATH=/home/vagrant/mysql

if [ -d $BUILD_PATH ]; then
    wget https://github.com/kamipo/mysql-build/archive/master.zip
    unzip master.zip $BUILD_PATH
fi
[ -d $MYSQL_PATH ] || mkdir $MYSQL_PATH

VERS=(
    4.0.30
    4.1.25
    5.0.96
    5.1.73
)

for ver in ${VERS[@]}; do
    cd $BUILD_PATH
    ./bin/mysql-build -v $ver "$MYSQL_PATH/$ver"

    cd "$MYSQL_PATH/$ver"
    ./bin/mysql_install_db
done

VERSs=(
    5.5.36
    5.6.16
    5.7.3-m13
)

for ver in ${VERSs[@]}; do
    cd $BUILD_PATH
    ./bin/mysql-build -v $ver "$MYSQL_PATH/$ver"

    cd "$MYSQL_PATH/$ver"
    ./scripts/mysql_install_db
done

rm -rf $BUILD_PATH
chown -R vagrant:vagrant $MYSQL_PATH
