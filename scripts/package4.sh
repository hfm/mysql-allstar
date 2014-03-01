#!/bin/sh

set -e

PATH=/usr/bin:/sbin:/usr/sbin:/usr/local/bin:$PATH

osarch=`uname -i`

curl -o /usr/share/ssl/certs/ca-bundle.crt -kL "https://www.digicert.com/testroot/DigiCertHighAssuranceEVRootCA.crt"

rpm -Uvh "http://www.sudo.ws/sudo/dist/packages/Centos/4/sudo-1.8.9-6.el4.${osarch}.rpm"

cat <<'EOT' > /etc/yum.repos.d/CentOS-Base.repo
[base]
name=CentOS-$releasever - Base
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os
baseurl=http://vault.centos.org/4.9/os/$basearch/
gpgcheck=1
gpgkey=http://mirror.centos.org/centos/RPM-GPG-KEY-centos4
priority=1
protect=1

#released updates
[update]
name=CentOS-$releasever - Updates
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates
baseurl=http://vault.centos.org/4.9/updates/$basearch/
gpgcheck=1
gpgkey=http://mirror.centos.org/centos/RPM-GPG-KEY-centos4
priority=1
protect=1

#packages used/produced in the build but not released
[addons]
name=CentOS-$releasever - Addons
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=addons
baseurl=http://vault.centos.org/4.9/addons/$basearch/
gpgcheck=1
gpgkey=http://mirror.centos.org/centos/RPM-GPG-KEY-centos4
priority=1
protect=1

#additional packages that may be useful
[extras]
name=CentOS-$releasever - Extras
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras
baseurl=http://vault.centos.org/4.9/extras/$basearch/
gpgcheck=1
gpgkey=http://mirror.centos.org/centos/RPM-GPG-KEY-centos4
priority=1
protect=1
EOT

rpm -ivh "http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/4/${osarch}/epel-release-4-10.noarch.rpm"

PACKAGE=(
    bison
    byacc
    curl-devel
    make
    cmake
    gcc-c++
    ncurses-devel
    puppet
)
yum install -y ${PACKAGE[@]}

yum update -y

yum clean all
