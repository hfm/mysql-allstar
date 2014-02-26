# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.guest = :redhat

  config.vm.define "centos4-i386" do |c|
    c.vm.box      = "CentOS4.8-i386-mysql-allstar"
    c.vm.box_url  = "./builds/centos4.8-i386-mysql-allstar.box"
    c.vm.hostname = "mysqlallstar.centos4i386.dev"
    c.vm.network :forwarded_port, guest: 3306, host: 33060
    c.vm.network :private_network, ip: "192.168.2.100", virtualbox__intnet: "mysql_network"
  end

  config.vm.define "centos4-x86" do |c|
    c.vm.box      = "CentOS4.8-x86_64-mysql-allstar"
    c.vm.box_url  = "./builds/centos4.8-x86_64-mysql-allstar.box"
    c.vm.hostname = "mysqlallstar.centos4x86.dev"
    c.vm.network :forwarded_port, guest: 3306, host: 33061
    c.vm.network :private_network, ip: "192.168.2.101", virtualbox__intnet: "mysql_network"
  end

  config.vm.define "centos5-i386" do |c|
    c.vm.box      = "CentOS5.10-i386-mysql-allstar"
    c.vm.box_url  = "./builds/centos5.10-i386-mysql-allstar.box"
    c.vm.hostname = "mysqlallstar.centos5i386.dev"
    c.vm.network :forwarded_port, guest: 3306, host: 33062
    c.vm.network :private_network, ip: "192.168.2.102", virtualbox__intnet: "mysql_network"
  end

  config.vm.define "centos5-x86" do |c|
    c.vm.box      = "CentOS5.10-x86_64-mysql-allstar"
    c.vm.box_url  = "./builds/centos5.10-x86_64-mysql-allstar.box"
    c.vm.hostname = "mysqlallstar.centos5x86.dev"
    c.vm.network :forwarded_port, guest: 3306, host: 33063
    c.vm.network :private_network, ip: "192.168.2.103", virtualbox__intnet: "mysql_network"
  end

  config.vm.define "centos6-i386" do |c|
    c.vm.box      = "CentOS6.5-i386-mysql-allstar"
    c.vm.box_url  = "./builds/centos6.5-i386-mysql-allstar.box"
    c.vm.hostname = "mysqlallstar.centos6i386.dev"
    c.vm.network :forwarded_port, guest: 3306, host: 33064
    c.vm.network :private_network, ip: "192.168.2.104", virtualbox__intnet: "mysql_network"
  end

  config.vm.define "centos6-x86" do |c|
    c.vm.box      = "CentOS6.5-x86_64-mysql-allstar"
    c.vm.box_url  = "./builds/centos6.5-x86_64-mysql-allstar.box"
    c.vm.hostname = "mysqlallstar.centos6x86.dev"
    c.vm.network :forwarded_port, guest: 3306, host: 33065
    c.vm.network :private_network, ip: "192.168.2.105", virtualbox__intnet: "mysql_network"
  end
end
