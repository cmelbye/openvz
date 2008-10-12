$LOAD_PATH << './lib'
require 'openvz'
require 'yaml'

config = YAML.load_file("config.yaml")

openvz = OpenVZ.new(:hostname => config['hostname'],
                    :username => config['username'],
                    :password => config['password'])

puts

openvz.run do |ssh|
  openvz.list.each do |server|
    header = 'Virtual Server ' + server[:veid].to_s
    puts header
    puts '-' * header.length
    puts "Processes:\t" + server[:nproc]
    puts "Server Status:\t" + server[:status]
    puts "IP Address:\t" + server[:ip]
    puts "Hostname:\t" + openvz.exec('vzctl exec ' + server[:veid].to_s + ' hostname')
    puts
  end
end
