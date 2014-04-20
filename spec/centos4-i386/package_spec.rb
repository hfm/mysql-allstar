require 'spec_helper'

%w(
  bison
  byacc
  cmake
  gcc
  gcc-c++
  git
  make
  ncurses-devel
  puppet
  chef
).each do |p|
  describe package(p) do
    it { should be_installed }
  end
end
