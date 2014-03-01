#!/bin/sh

set -e

PATH=/usr/local/bin:/usr/bin:/sbin:/usr/sbin:$PATH

BUILD_PATH=/home/vagrant/mysql-build
MYSQL_PATH=/home/vagrant/mysql

echo "Use newer git"
curl -OLk "https://git-core.googlecode.com/files/git-1.9.0.tar.gz"
tar zxfv git-1.9.0.tar.gz
cd git-1.9.0
./configure && make && make install

[ -d $BUILD_PATH ] || git clone https://github.com/kamipo/mysql-build.git $BUILD_PATH
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
)

for ver in ${VERSs[@]}; do
    cd $BUILD_PATH
    ./bin/mysql-build -v $ver "$MYSQL_PATH/$ver"

    cd "$MYSQL_PATH/$ver"
    ./scripts/mysql_install_db
done

rm -rf $BUILD_PATH /home/vagrant/git-1.9.0 /home/vagrant/git-1.9.0.tar.gz
chown -R vagrant:vagrant $MYSQL_PATH
