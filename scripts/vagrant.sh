#!/bin/sh -e

PATH=/usr/bin:/sbin:/usr/sbin:/usr/local/bin:$PATH

mkdir -p /home/vagrant/.ssh
curl -o /home/vagrant/.ssh/authorized_keys -L 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
chown -R vagrant /home/vagrant/.ssh
chmod -R go-rwsx /home/vagrant/.ssh

cat <<'EOF' > /home/vagrant/.bash_profile
[ -f ~/.bashrc ] && . ~/.bashrc
export PATH=$PATH:/sbin:/usr/sbin:$HOME/bin
EOF
