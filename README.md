# MySQL AllStar

MySQL 4.0 ~ 5.6 in one.

## Usage

Download boxes in [releases](https://github.com/tacahilo/mysql-allstar/releases), and vagrant up them.

```console
$ vagrant init centos-6.5-x86_64-mysql-allstar https://github.com/tacahilo/mysql-allstar/releases/download/v0.1/centos-6.5-x86_64-mysql-allstar.box
$ vagrant up
```

## Build with packer on your own

```console
$ brew tap homebrew/binary
$ brew install packer
$ packer build packer/centos-<osversion>-<osarch>.json
```

### test box

```console
$ bundle install --path vendor
$ bundle exec rake vagrant:centos6-x86
```
