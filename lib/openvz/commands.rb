class OpenVZ
  
  def list
    lines = exec('vzlist')
    lines = lines.to_a
    servers = []
    lines.shift
    lines.each do |line|
      server = {}
      server[:veid], server[:nproc], server[:status], server[:ip], server[:hostname] = line.scan(/\S+/)
      servers << server
    end
    return servers
  end
  
end