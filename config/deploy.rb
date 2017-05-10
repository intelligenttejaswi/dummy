# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "dummy"
set :repo_url, "git@github.com:intelligenttejaswi/dummy.git"
set :deploy_user, "tejaswi"
set :stages, ["beta", "production","development"]
set :default_stage, "development"
set :deploy_to, "/home/#{fetch :deploy_user }/apps/#{fetch :application}/#{fetch :stage}" 

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

set :unicorn_config_path, "#{fetch :deploy_to}/current/config/unicorn.rb"
# set :unicorn_options, "-E #{fetch :stage} -D"
