#!/bin/sh

set -e

osmajor=$(awk '{print $3}' /etc/redhat-release | sed 's/\..*//')
osarch=`uname -i`

# puppetlabs
curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs -L 'https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs'
rpm -ivh "http://yum.puppetlabs.com/el/${osmajor}/products/${osarch}/puppetlabs-release-${osmajor}-10.noarch.rpm"

# epel
curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL -L "http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/RPM-GPG-KEY-EPEL"
if [ $osmajor -eq 5 ];then
    rpm -ivh "http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/5/${osarch}/epel-release-5-4.noarch.rpm"
else
    rpm -ivh "http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/6/${osarch}/epel-release-6-8.noarch.rpm"
fi

# rpmforge
if [ $osmajor -eq 5 ];then
    rpmforge=rpmforge-release-0.5.3-1.el5.rf.${osarch}.rpm
    rpm --import -v http://apt.sw.be/RPM-GPG-KEY.dag.txt
    curl -OL "http://pkgs.repoforge.org/rpmforge-release/${rpmforge}"
    rpm -K $rpmforge
    rpm -ivh $rpmforge
    rm -f $rpmforge
    sed -i 's/enabled = 1/enabled = 0/' /etc/yum.repos.d/rpmforge.repo
fi

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
if [ $osmajor -eq 5 ];then
    yum --enablerepo=rpmforge -y install git
else
    yum -y install git
fi

yum clean all
