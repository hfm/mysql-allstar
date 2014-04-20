#!/bin/bash

PATH=/usr/local/bin:/usr/bin:/sbin:/usr/sbin:$PATH

build_path=/home/vagrant/mysql-build
mysql_path=/home/vagrant/mysql

[ -d $build_path ] || git clone https://github.com/kamipo/mysql-build.git $build_path
mkdir -p $mysql_path

VERS=(
    4.0.30
    4.1.25
    5.0.96
    5.1.73
    5.5.37
    5.6.17
)


# global my.cnf
cat<<'EOS' >/etc/my.cnf
[client]
user = vagrant

[mysqld]
user = vagrant

[mysqlhotcopy]
interactive-timeout

[mysqldump]
quick
EOS


# install each mysql
pushd $build_path
for ver in ${VERS[@]}; do
    ./bin/mysql-build $ver "${mysql_path}/${ver}"
done
popd


# setup directory and my.cnf
for ver in ${VERS[@]}; do
    pushd "${mysql_path}/${ver}"

    mkdir ${mysql_path}/${ver}/etc
    mkdir -p ${mysql_path}/${ver}/var/{log,lib}/mysql

    cat<<EOS >${mysql_path}/${ver}/etc/my.cnf
[client]
socket = ${mysql_path}/${ver}/var/lib/mysql

[mysqld]
socket = ${mysql_path}/${ver}/var/lib/mysql
default-character-set = utf8
EOS

    mysqlmajor=$(${mysql_path}/${ver}/bin/mysql --version | awk '{print $5}' | cut -f1 -d'.')
    if [ $mysqlmajor -eq 5 ]; then
        cat<<EOS >>${mysql_path}/${ver}/etc/my.cnf
innodb_data_file_path=ibdata1:10M:autoextend
innodb_file_per_table
EOS
    fi

    popd
done


# setup for mysql_install_db
for ver in ${VERS[@]}; do
    pushd "${mysql_path}/${ver}"

    if [ -f "bin/mysql_install_db" ]; then
        ./bin/mysql_install_db
    else
        ./scripts/mysql_install_db
    fi

    popd
done

chown -R vagrant:vagrant $build_path
chown -R vagrant:vagrant $mysql_path
