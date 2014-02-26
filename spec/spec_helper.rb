require 'serverspec'
require 'pathname'
require 'net/ssh'

include SpecInfra::Helper::Ssh
include SpecInfra::Helper::DetectOS

RSpec.configure do |c|
  if ENV['SERVERSPEC_ENV'] == 'vagrant'
    c.host  = ENV['VMNAME']
    puts    "\n## Running Tests on #{c.host}"

    user    = 'vagrant'
    host    = '127.0.0.1'
    options = Net::SSH::Config.for(c.host)
    config  = `vagrant ssh-config #{c.host}`

    if config != ''
      config.each_line do |line|
        if match = /HostName (.*)/.match(line)
          host = match[1]
        elsif  match = /User (.*)/.match(line)
          user = match[1]
        elsif match = /IdentityFile (.*)/.match(line)
          options[:keys] =  [match[1].gsub(/"/,'')]
        elsif match = /Port (.*)/.match(line)
          options[:port] = match[1]
        end
      end
    end

    c.ssh   = Net::SSH.start(host, user, options)
  end
end
