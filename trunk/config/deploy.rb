set :application, "feedcatcher"
set :repository,  "http://scripts.njae.me.uk/svn/m8rails/#{application}/branches/stable"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/feedcatcher.njae.me.uk/"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :subversion
set :scm_username, 'neil'

role :app, "feedcatcher.njae.me.uk"
role :web, "feedcatcher.njae.me.uk"
role :db,  "feedcatcher.njae.me.uk", :primary => true

# Have the spinner/spawner/reaper processes run as the default user
set :runner, nil

# Copy the database.yml file across, as it's not kept in the SVN repository
after "deploy:update_code" , :configure_database
desc "copy database.yml into the current release path"
task :configure_database, :roles => :app do
  db_config = "#{deploy_to}/config/database.yml"
  run "cp #{db_config} #{release_path}/config/database.yml"
end


namespace :deploy do
  task :start, :roles => :app do
  end

  task :stop, :roles => :app do
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{release_path}/tmp/restart.txt"
  end

end
