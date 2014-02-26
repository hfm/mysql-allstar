require 'spec_helper'

%w(
  /etc/yum.repos.d/epel.repo
  /etc/yum.repos.d/rpmforge.repo
  /etc/yum.repos.d/puppetlabs.repo
).each do |f|
  describe file(f) do
    it { should be_file }
  end
end

describe file('/etc/yum.repos.d/rpmforge.repo') do
  its(:content) { should_not match /enable = 1/ }
end
