#!/bin/sh

yum -y clean all
rm -rf *.iso *.iso.?
rm -rf /tmp/*

sed -i 's/^HWADDR.*$//' /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i 's/^UUID.*$//' /etc/sysconfig/network-scripts/ifcfg-eth0
