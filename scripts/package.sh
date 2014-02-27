#!/bin/sh

set -e

PATH=/usr/bin:/sbin:/usr/sbin:/usr/local/bin:$PATH

osmajor=$(awk '{print $3}' /etc/redhat-release | sed 's/\..*//')
osarch=`uname -i`

# epel
if [ ! $osmajor -eq 4 ]; then
    curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL -L "http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/RPM-GPG-KEY-EPEL"
else
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
    yum update -y
fi

if [ $osmajor -eq 4 ]; then
    rpm -ivh "http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/4/${osarch}/epel-release-4-10.noarch.rpm"
elif [ $osmajor -eq 5 ]; then
    rpm -ivh "http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/5/${osarch}/epel-release-5-4.noarch.rpm"
else
    rpm -ivh "http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/6/${osarch}/epel-release-6-8.noarch.rpm"
fi

# rpmforge
if [ $osmajor -eq 5 ]; then
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
if [ $osmajor -eq 5 ]; then
    yum --enablerepo=rpmforge -y install git
else
    yum -y install git
fi

yum clean all
