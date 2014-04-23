#!/bin/sh

set -e

osarch=`uname -i`
osmajor=$(cut -f3 -d' ' /etc/redhat-release | cut -f1 -d'.')

# epel
case $osmajor in
    4)
        epel='epel-release-4-10.noarch.rpm'
        ;;
    5)
        epel='epel-release-5-4.noarch.rpm'
        ;;
    6)
        epel='epel-release-6-8.noarch.rpm'
        ;;
    *)
        echo "$osmajor Didn't match anything"
esac

curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL -L "http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/RPM-GPG-KEY-EPEL-$osmajor"
rpm -ivh "http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/$osmajor/$osarch/$epel"


if [ $osmajor == 4 ]; then
    curl -OLk "https://git-core.googlecode.com/files/git-1.9.0.tar.gz"
    tar zvxf git-1.9.0.tar.gz
    cd git-1.9.0 && ./configure && make make install
    rm -rf /home/vagrant/git-1.9.0{,.tar.gz}

    curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs -L 'http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs'
    rpm -ivh "https://yum.puppetlabs.com/el/$osmajor/products/$osarch/puppetlabs-release-$osmajor-10.noarch.rpm"
elif [ "$osmajor" == 5 ]; then
    rpmforge=rpmforge-release-0.5.3-1.el5.rf.${osarch}.rpm
    rpm --import -v http://apt.sw.be/RPM-GPG-KEY.dag.txt
    curl -OL "http://pkgs.repoforge.org/rpmforge-release/${rpmforge}"
    rpm -Kv $rpmforge
    rpm -ivh $rpmforge
    sed -i 's/enabled = 1/enabled = 0/' /etc/yum.repos.d/rpmforge.repo
    yum --enablerepo=rpmforge -y install git
    rm $rpmforge
fi

packages=(
    bison
    byacc
    cmake
    gcc
    gcc-c++
    make
    ncurses-devel
    openssl-devel
    readline-devel
    zlib-devel
)

yum install -y puppet ${packages[@]}

# chef
curl -kL 'https://www.opscode.com/chef/install.sh' | bash
