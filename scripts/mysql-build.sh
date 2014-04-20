#!/bin/bash

PATH=/usr/local/bin:/usr/bin:/sbin:/usr/sbin:$PATH

build_path=/home/vagrant/mysql-build
mysql_path=/home/vagrant/mysql

[ -d $build_path ] || git clone https://github.com/kamipo/mysql-build.git $build_path

groupadd mysql
useradd -s /sbin/nologin -g mysql mysql
install -o vagrant -g vagrant -d $mysql_path

VERS=(
    4.0.30
    4.1.25
    5.0.96
    5.1.73
    5.5.37
    5.6.17
)

pushd $build_path
for ver in ${VERS[@]}; do
    ./bin/mysql-build $ver "${mysql_path}/${ver}"
done
popd

pushd "${mysql_path}/${ver}"
for ver in ${VERS[@]}; do
    mkdir "${mysql_path}/${ver}/etc"
    mkdir -p "${mysql_path}/${ver}/{log,lib}/mysql"
    ./bin/mysql_install_db
    ./scripts/mysql_install_db
done
popd

chown -R vagrant:vagrant $build_path
chown -R vagrant:vagrant $mysql_path
