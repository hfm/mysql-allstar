require 'spec_helper'

%w(
  /etc/yum.repos.d/epel.repo
  /etc/yum.repos.d/puppetlabs.repo
).each do |y|
  describe file(p) do
    it { should be_file }
  end
end
