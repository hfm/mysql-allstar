require 'spec_helper'

%w(
  /home/vagrant/mysql/4.0.30/bin/mysql
  /home/vagrant/mysql/4.1.25/bin/mysql
  /home/vagrant/mysql/5.0.96/bin/mysql
  /home/vagrant/mysql/5.1.73/bin/mysql
  /home/vagrant/mysql/5.5.36/bin/mysql
  /home/vagrant/mysql/5.6.16/bin/mysql
).each do |f|
  describe file(f) do
    it { should be_executable }
  end
end
