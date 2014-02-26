require 'serverspec'
require 'pathname'
require 'net/ssh'

include SpecInfra::Helper::Ssh
include SpecInfra::Helper::DetectOS

host = ENV['VMNAME']

puts "\n## Running Tests on #{host} >>>"

options = Net::SSH::Config.for(host)
config  = `vagrant ssh-config #{host}`

rhost   = ''
user    = 'vagrant'

config.each_line do |line|
  if match = /HostName (.*)/.match(line)
    rhost = match[1]
  elsif  match = /User (.*)/.match(line)
    user = match[1]
  elsif match = /IdentityFile (.*)/.match(line)
    options[:keys] =  [match[1].gsub(/"/,'')]
  elsif match = /Port (.*)/.match(line)
    options[:port] = match[1]
  end
end

SpecInfra.configuration.ssh = Net::SSH.start(rhost, user, options)

property[:os] = backend.check_os
