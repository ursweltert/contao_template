# DEVELOPMENT-Einstellungen

set :user, 'user'
set :server, 'server.local'

role :web, "#{fetch :user}@#{fetch :server}:22"
role :app, "#{fetch :user}@#{fetch :server}:22"
role :db,  "#{fetch :user}@#{fetch :server}:22", primary: true

# The project's branch to use
set :branch, 'develop'

# Use sudo ?
set :use_sudo, false

# Define deployments options
set :deploy_to,   -> { "/path/to/local/deploy/#{fetch :stage}/#{fetch :application}" }
set :logs_path,   -> { "#{fetch :deploy_to}/logs" }
set :public_path, -> { "#{fetch :current_path}/public" }
set :backup_path, -> { "#{fetch :deploy_to}/backups" }

# How should we deploy?
# Valid options:
# => checkout: this deployment strategy does an SCM checkout on each target
#              host. This is the default deployment strategy for Capistrano.
#
# => copy: this deployment strategy work by preparing the source code locally,
#          compressing it, copying the file to each target host, and
#          uncompressing it to the deployment directory.
#          NOTE: This strategy has more options you can configure, please refer
#                to capistrano/recipes/deploy/strategy/copy.rb (in capistrano)
#                source or documentation for more information
#
# => export: this deployment strategy does an SCM export on each target host.
#
# => remote_cache: this deployment strategy keeps a cached checkout of the
#                  source code on each remote server. Each deploy simply updates
#                  the cached checkout, and then does a copy from the cached
#                  copy to the final deployment location.
set :deploy_via,  :remote_cache

# Keep only the last 5 releases
set :keep_releases, 5

#############
# Contents
#

# Here you can set all the contents folders, a content folder is a shared folder
# public or private but the contents are shared between all releases.
# The contents_folders is a hash of key/value where the key is the name of the folder
# created under 'shared_path/contents' and symlinked to the value (absolute path)
# you can use public_path/current_path/deploy_to etc...
set :content_folders, {
  'inhalte' => "#{fetch :public_path}/tl_files/#{fetch :application}/inhalte"
}

# Here you can define which files/folder you would like to keep, these files
# and folders are not considered contents so they will not be synced from one
# server to another with the tasks mulltistage:sync:* instead they will be kept
# between versions in the shared/items folder
set :shared_items, [
  'public/system/config/localconfig.php',
  'public/.htaccess',
  'public/sitemap.xml',
]


#
#
#############

#############
# Databases
#

# What is the type of your database server ?
# Available options: mysql
set :db_server_app, :mysql

# What is the database name for this project/stage ?
# set :db_database_name, -> { "#{fetch :user}_#{fetch :application}_#{fetch :stage}" }
set :db_database_name, -> { "#{fetch :application}" }

# What is the database user ?
set :db_username, -> { "root" }

# Tables to skip on import
# set :skip_tables_on_import, [
#   'tl_formdata',
#   'tl_formdata_details',
# ]

# Where the database credentials are stored on the server ?
set :db_credentials_file, -> { "../config/.my.cnf.yml"}

# Where can we find root credentials ?
# NOTE: Only required for db_create_user
set :db_root_credentials_file, -> { "../config/.my.cnf.yml"}


