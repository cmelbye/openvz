require 'rubygems'
require 'net/ssh'
require 'openvz/helper'
require 'openvz/commands'

class OpenVZ
  attr_reader :hostname, :username, :password
  
  def initialize(args)
    # Converting all the args keys to symbols
    args.each_pair do |k,v|
      args.delete(k)
      args[k.to_sym] = v if k.respond_to? :to_sym
    end
    
    # Converting all the options keys to symbols
    if args[:options].is_a? Hash
      args[:options].each_pair do |k,v|
        args[:options].delete(k)
        args[:options][k.to_sym] = v if k.respond_to? :to_sym
      end
    end

    @hostname = args[:hostname].to_s
    @username = args[:username].to_s
    @password = args[:password].to_s
    
    # Argument Checking
    raise ArgumentError, 'No hostname specified' unless @hostname
    raise ArgumentError, 'No username specified' unless @username
    raise ArgumentError, 'No password specified' unless @password
  end
  
  def exec(command, sudo = true)
    if sudo
      command = 'sudo ' + command.to_s
    end
    Net::SSH.start(@hostname, @username, :password => @password) do |ssh|
      output = ssh.exec!(command)
      return output
    end
  end
  
  def run(&blk)
    Net::SSH.start(@hostname, @username, {:password => @password}, &blk)
  end
end
