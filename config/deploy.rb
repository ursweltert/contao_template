require File.expand_path('../application', __FILE__)

# Bitte nur scp fürs deployment verwenden
module UseScpForDeployment
  def self.included(base)
    base.send(:alias_method, :old_upload, :upload)
    base.send(:alias_method, :upload,     :new_upload)
  end

	def new_upload(from, to, options = {}, &block)
		old_upload(from, to, options.merge(:via => :scp), &block)
	end
end

Capistrano::Configuration.send(:include, UseScpForDeployment)

######################
## PROJECT SETTINGS ##
######################

set :default_environment, {
  'PATH' => "$HOME/local/bin:$HOME/.rvm/bin:$PATH"
}

set :application,           Rails.application.config.contao.application_name
set :scm,                   :git
set :git_enable_submodules, true

# What is the repository ?
# Default: Whatever the origin is set to
# set :project_repository,    'set your repository location here'

# Stages
set :stages, ['development', 'staging', 'production']
set :default_stage, :development

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

##################
## DEPENDENCIES ##
##################

after 'deploy', 'deploy:cleanup' # keeps only last 5 releases

##################
## REQUIREMENTS ##
##################

require 'capistrano/ext/contao'

set :rails_env, "development"
set :db_local_clean, false

# If you want to import assets, you can change default asset dir (default = system)
# This directory must be in your shared directory on the server
# set :assets_dir, %w(public/assets public/att)

# if you want to work on a specific local environment (default = ENV['RAILS_ENV'] || 'development')
set :local_rails_env, "development"


