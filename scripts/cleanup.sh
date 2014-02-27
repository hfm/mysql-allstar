#!/bin/sh -e

PATH=/usr/bin:/sbin:/usr/sbin:$PATH

yum -y clean all
rm -rf *.iso *.iso.?
rm -rf /tmp/*

sed -i 's/^HWADDR.*$//' /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i 's/^UUID.*$//' /etc/sysconfig/network-scripts/ifcfg-eth0

dd if=/dev/zero of=/EMPTY bs=1M
rm -rf /EMPTY
sync
