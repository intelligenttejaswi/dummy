# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "dummy.com"
set :repo_url, "git@github.com:intelligenttejaswi/dummy.git"
set :deploy_user, "tejaswi"
set :stages, ["beta", "production","development"]
set :default_stage, "development"



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
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/assets"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :bundle_without, nil   
# Default value for keep_releases is 5
set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    set :unicorn_config_path, "#{fetch :deploy_to}/current/config/unicorn.rb"
    invoke 'unicorn:restart'
    invoke 'nginx:site:add'
    invoke 'nginx:site:enable'
    invoke 'nginx:restart'
  end
end

set :unicorn_rack_env, "#{fetch :stage}"
 

set :app_server, true
set :nginx_sudo_paths, [:nginx_sites_enabled_dir, :nginx_sites_available_dir]
set :nginx_static_dir, "public"
set :nginx_application_name, "#{fetch :branch}.#{fetch :application}"
set :app_server_host, "#{fetch :branch}.#{fetch :application}"
set :nginx_template, "#{stage_config_path}/templates/nginx/#{fetch :stage}.erb"
