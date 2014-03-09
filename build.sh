#!/bin/sh

PATH=/usr/local/bin:$PATH

packer build packer/centos-4.8-i386.json
packer build packer/centos-4.8-x86_64.json
packer build packer/centos-5.10-i386.json
packer build packer/centos-5.10-x86_64.json
packer build packer/centos-6.5-i386.json
packer build packer/centos-6.5-x86_64.json
