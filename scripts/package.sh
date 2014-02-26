#!/bin/sh -e

curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs -L 'https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs'
cat <<'EOF' > /etc/yum.repos.d/puppetlabs.repo
[puppetlabs-products]
name=Puppet Labs Products El $releasever - $basearch
baseurl=http://yum.puppetlabs.com/el/$releasever/products/$basearch
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs
enabled=1
gpgcheck=1

[puppetlabs-deps]
name=Puppet Labs Dependencies El $releasever - $basearch
baseurl=http://yum.puppetlabs.com/el/$releasever/dependencies/$basearch
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs
enabled=1
gpgcheck=1
EOF

cat <<'EOF' > /etc/yum.repos.d/epel
[epel]
name=Extra Packages for Enterprise Linux $releasever - $basearch
#baseurl=http://download.fedoraproject.org/pub/epel/$releasever/$basearch
mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=x86_64
failovermethod=priority
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-$releasever

[epel-debuginfo]
name=Extra Packages for Enterprise Linux $releasever - $basearch - Debug
#baseurl=http://download.fedoraproject.org/pub/epel/$releasever/$basearch/debug
mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-debug-6&arch=$basearch
failovermethod=priority
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-$releasever
gpgcheck=1

[epel-source]
name=Extra Packages for Enterprise Linux $releasever - $basearch - Source
#baseurl=http://download.fedoraproject.org/pub/epel/$releasever/SRPMS
mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-source-6&arch=$basearch
failovermethod=priority
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-$releasever
gpgcheck=1
EOF


PACKAGE=(
    bison
    byacc
    make
    git
    gcc-c++
    ncurses-devel
    puppet
)
for p in ${PACKAGE[@]}; do
    yum -y install $p
done
