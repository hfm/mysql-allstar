require 'rake'
require 'rspec/core/rake_task'

task :default do
  sh "rake -T"
end

desc "Run serverspec to all vm"
task :vagrant => "vagrant:all"

namespace :vagrant do
  vms = %w(
    centos4-i386
    centos4-x86
    centos5-i386
    centos5-x86
    centos6-i386
    centos6-x86
  )
  task :all => vms.map { |vm| "vagrant:#{vm}" }

  vms.each do |vm|
    desc "Run serverspec to #{vm}"
    RSpec::Core::RakeTask.new(vm.to_sym) do |t|
      ENV['VMNAME'] = vm
      t.pattern = "spec/#{vm}/*_spec.rb"
    end
  end
end
