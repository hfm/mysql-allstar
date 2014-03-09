#!/bin/sh

set -e

PATH=/usr/bin:/sbin:/usr/sbin:/usr/local/bin:$PATH


cat <<'EOT' > /etc/yum.repos.d/CentOS-Base.repo
[base]
name=CentOS-$releasever - Base
baseurl=http://vault.centos.org/4.9/os/$basearch/
gpgcheck=1
gpgkey=http://mirror.centos.org/centos/RPM-GPG-KEY-centos4
priority=1
protect=1

#released updates
[update]
name=CentOS-$releasever - Updates
baseurl=http://vault.centos.org/4.9/updates/$basearch/
gpgcheck=1
gpgkey=http://mirror.centos.org/centos/RPM-GPG-KEY-centos4
priority=1
protect=1

#packages used/produced in the build but not released
[addons]
name=CentOS-$releasever - Addons
baseurl=http://vault.centos.org/4.9/addons/$basearch/
gpgcheck=1
gpgkey=http://mirror.centos.org/centos/RPM-GPG-KEY-centos4
priority=1
protect=1

#additional packages that may be useful
[extras]
name=CentOS-$releasever - Extras
baseurl=http://vault.centos.org/4.9/extras/$basearch/
gpgcheck=1
gpgkey=http://mirror.centos.org/centos/RPM-GPG-KEY-centos4
priority=1
protect=1
EOT

osarch=`uname -i`
rpm -ivh "http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/4/${osarch}/epel-release-4-10.noarch.rpm"
yum install -y puppet cmake
