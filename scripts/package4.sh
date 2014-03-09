#!/bin/sh

set -e

PATH=/usr/bin:/sbin:/usr/sbin:/usr/local/bin:$PATH

echo "Use newer git"
curl -OLk "https://git-core.googlecode.com/files/git-1.9.0.tar.gz"
tar zxfv git-1.9.0.tar.gz
cd git-1.9.0
./configure && make && make install
rm -rf /home/vagrant/git-1.9.0 /home/vagrant/git-1.9.0.tar.gz

osarch=`uname -i`
rpm -ivh "http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/4/${osarch}/epel-release-4-10.noarch.rpm"
yum install -y puppet cmake
