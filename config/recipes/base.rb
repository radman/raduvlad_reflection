def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end


namespace :deploy do
  desc "Remove current app from the server"
  task :remove_app do
    run "#{sudo} rm -rf #{deploy_to}"

    run "#{sudo} rm -f /etc/nginx/sites-enabled/#{application}"
    run "#{sudo} update-rc.d -f #{application} remove"
    mysql "drop database #{wordpress_db_name};"
  end
  after "deploy:remove_app", "nginx:restart"
  
end

