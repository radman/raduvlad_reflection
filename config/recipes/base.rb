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
    run "rm -rf #{deploy_to}"

    run "#{sudo} rm -f /etc/nginx/sites-enabled/#{application}"
    #run "#{sudo} rm -f /etc/init.d/unicorn_#{application}"
    #run "#{sudo} update-rc.d -f unicorn_#{application} remove"

    #run %Q{#{sudo} -u postgres psql -c "select pg_terminate_backend(procpid) from pg_stat_activity where datname='#{application}';"}
    #run %Q{#{sudo} -u postgres psql -c "drop database #{application}_production;"}
    #run %Q{#{sudo} -u postgres psql -c "drop role #{application};"}
  end
  after "deploy:remove_app", "nginx:restart"
  
end

