class OpenVZ
  
  def exec(ssh, command, sudo = true)
    if sudo
      command = 'sudo' + command.to_s
    else
      command = command.to_s
    end
    return ssh.exec!(command)
  end
  
end