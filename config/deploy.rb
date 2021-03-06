#set :application, "set your application name here"
set :repository, "git@github.com:railsrumble/rr10-team-174.git"  # Your clone URL
set :scm, "git"
set :user, "deploy"  # The server's user for deploys
set :deploy_to, "/var/app/letsgivethis.com"
set :branch, "master"
set :deploy_via, :remote_cache
ssh_options[:forward_agent] = true

role :web, "69.172.229.156"                          # Your HTTP server, Apache/etc
role :app, "69.172.229.156"                          # This may be the same as your `Web` server
role :db,  "69.172.229.156", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     # run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
     run "touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end
