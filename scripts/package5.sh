#!/bin/sh

set -e

PATH=/usr/bin:/sbin:/usr/sbin:/usr/local/bin:$PATH

osarch=`uname -i`

# puppet
puppetrepo=puppetlabs-release-5-10.noarch.rpm
rpm --import -v "http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs"
wget "https://yum.puppetlabs.com/el/5/products/${osarch}/${puppetrepo}"
rpm -K $puppetrepo
rpm -ivh $puppetrepo
rm -f $puppetrepo

# epel
epel=epel-release-5-4.noarch.rpm
rpm --import -v "http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/RPM-GPG-KEY-EPEL"
wget "http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/5/${osarch}/${epel}"
rpm -K $epel
rpm -ivh $epel
rm -f $epel

# rpmforge
rpmforge=rpmforge-release-0.5.3-1.el5.rf.${osarch}.rpm
rpm --import -v http://apt.sw.be/RPM-GPG-KEY.dag.txt
curl -OL "http://pkgs.repoforge.org/rpmforge-release/${rpmforge}"
rpm -Kv $rpmforge
rpm -ivh $rpmforge
rm -f $rpmforge
sed -i 's/enabled = 1/enabled = 0/' /etc/yum.repos.d/rpmforge.repo

# package install
PACKAGE=(
    bison
    byacc
    make
    cmake
    gcc-c++
    ncurses-devel
    puppet
)
yum -y install ${PACKAGE[@]}
yum --enablerepo=rpmforge -y install git
