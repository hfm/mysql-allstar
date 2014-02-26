require 'spec_helper'

%w(
  /home/vagrant/mysql/4.0.30/bin/mysql
  /home/vagrant/mysql/4.1.25/bin/mysql
  /home/vagrant/mysql/5.0.96/bin/mysql
  /home/vagrant/mysql/5.1.73/bin/mysql
  /home/vagrant/mysql/5.5.36/bin/mysql
  /home/vagrant/mysql/5.6.16/bin/mysql
  /home/vagrant/mysql/5.7.3-m13/bin/mysql
  /home/vagrant/mysql/facebook-5.6.12/bin/mysql
  /home/vagrant/mysql/mariadb-5.5.35/bin/mysql
  /home/vagrant/mysql/percona-5.5.34-32.0/bin/mysql
  /home/vagrant/mysql/percona-5.6.15-63.0/bin/mysql
  /home/vagrant/mysql/twitter-5.5.33.t12/bin/mysql
).each do |f|
  describe file(f) do
    it { should be_executable }
  end
end
