#set_default(:postgresql_host, "localhost")
#set_default(:postgresql_user) { application }
#set_default(:postgresql_password) { Capistrano::CLI.password_prompt "PostgreSQL Password: " }
#set_default(:postgresql_database) { "#{application}_production" }
#
#namespace :postgresql do
#  desc "Install the latest stable release of PostgreSQL."
#  task :install, roles: :db, only: {primary: true} do
#    run "#{sudo} add-apt-repository ppa:pitti/postgresql"
#    run "#{sudo} apt-get -y update"
#    run "#{sudo} apt-get -y install postgresql libpq-dev"
#  end
#  after "deploy:install", "postgresql:install"
#
#  desc "Create a database for this application."
#  task :create_database, roles: :db, only: {primary: true} do
#    run %Q{#{sudo} -u postgres psql -c "create user #{postgresql_user} with password '#{postgresql_password}';"}
#    run %Q{#{sudo} -u postgres psql -c "create database #{postgresql_database} owner #{postgresql_user};"}
#  end
#  after "deploy:setup", "postgresql:create_database"
#
#  desc "Generate the database.yml configuration file."
#  task :setup, roles: :app do
#    run "mkdir -p #{shared_path}/config"
#    template "postgresql.yml.erb", "#{shared_path}/config/database.yml"
#  end
#  after "deploy:setup", "postgresql:setup"
#
#  desc "Symlink the database.yml file into latest release"
#  task :symlink, roles: :app do
#    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
#  end
#  after "deploy:finalize_update", "postgresql:symlink"
#end
#


set_default(:wordpress_db_name) { "#{application.gsub(/-/,'_')}" }
set_default(:wordpress_db_user) { Capistrano::CLI.ui.ask "Wordpress DB User: " }
set_default(:wordpress_db_password) { Capistrano::CLI.password_prompt "Wordpress DB Password: " }
set_default(:wordpress_db_host, "localhost")
set_default(:wordpress_db_charset, "utf8")
set_default(:wordpress_db_collate, "") 
set_default(:wordpress_security_keys) { `curl -L https://api.wordpress.org/secret-key/1.1/salt/` }
set_default(:wordpress_table_prefix, "wp_")
set_default(:wordpress_wplang, "")
set_default(:wordpress_wp_debug, "false")

namespace :wordpress do
  desc "Generate the wp-config.php configuration file."
  task :setup, :roles => :web do
    template "wp-config.php.erb", "#{shared_path}/wp-config.php"
  end
  after "deploy:setup", "wordpress:setup"

  desc "Symlink the wp-config.php configuration file"
  task :symlink, :roles => :web do
    run "ln -nfs #{shared_path}/wp-config.php #{release_path}/wp-config.php"
  end
  after "deploy:finalize_update", "wordpress:symlink"

  desc "Create a database for this application."
  task :create_database, :roles => :web do
    mysql "create database #{wordpress_db_name};"
    mysql "grant all on #{wordpress_db_name}.* to '#{wordpress_db_user}'@'#{wordpress_db_host}' identified by '#{wordpress_db_password}'; flush privileges;"
  end
  after "wordpress:setup", "wordpress:create_database"
end
