require "bundler/capistrano"
require "rvm/capistrano"

#load "config/recipes/base"
#load "config/recipes/nginx"
#load "config/recipes/unicorn"
#load "config/recipes/postgresql"
before 'deploy:setup', 'rvm:install_rvm'
set :rvm_type, :system  # Copy the exact line. I really mean :system here
before "deploy", "deploy:setup"

set :rvm_ruby_string, '1.9.3-p286'
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
 set :rvm_install_with_sudo, true 

server "foundrapp.com", :web, :app, :db, primary: true

set :user, "nikko"
set :application, "Foundr"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :ssh_options, {:forward_agent => true}
set :scm_passphrase, "desert12"  # The deploy user's password

set :scm, "git"
set :repository, "git@github.com:nikkoschaff/Foundr.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases
after "deploy", "deploy:migrate"