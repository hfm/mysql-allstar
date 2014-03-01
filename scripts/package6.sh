#!/bin/sh

set -e

PATH=/usr/bin:/sbin:/usr/sbin:/usr/local/bin:$PATH

osarch=`uname -i`

# puppet
curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs -L "http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs"
rpm -ivh "https://yum.puppetlabs.com/el/6/products/${osarch}/puppetlabs-release-6-7.noarch.rpm"

# epel
curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL -L "http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/RPM-GPG-KEY-EPEL"
rpm -ivh "http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/6/${osarch}/epel-release-6-8.noarch.rpm"

# package install
PACKAGE=(
    bison
    byacc
    make
    cmake
    gcc-c++
    git
    ncurses-devel
    puppet
)
yum install -y ${PACKAGE[@]}

yum update -y
yum clean all
