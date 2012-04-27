require "capistrano_colors"

server "ec2-23-21-20-0.compute-1.amazonaws.com", :app
set :application, "bootstrap-wordpress"

set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, :git
set :repository, "git@github.com:radman/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true # for password prompts
ssh_options[:forward_agent] = true # forward local ssh keys to server (make sure you've used ssh-add for each key you want to forward)

after "deploy:restart", "deploy:cleanup" # keep only the last 5 releases
