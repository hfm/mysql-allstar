require 'spec_helper'

%w(
  bison
  byacc
  make
  gcc
  gcc-c++
  git
  ncurses-devel
  puppet
).each do |p|
  describe package(p) do
    it { should be_installed }
  end
end
