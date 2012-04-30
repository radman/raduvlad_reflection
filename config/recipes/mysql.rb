set_default(:mysql_root_password) { Capistrano::CLI.password_prompt "MySQL Root Password: " }

def mysql(sql_statements)
  run %Q{mysql -u root -p -e "#{sql_statements}"} do |channel, stream, data|
    channel.send_data("#{mysql_root_password}\n\r") if data =~ /Enter password:/
  end
end
