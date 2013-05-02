source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'oily_png', platforms: :mri

  gem 'compass', '>= 0.12.2'      # hinzugefügt
  gem 'compass-rails', '>= 1.0.3' # war vorher ohne Versionsnummer
  gem 'compass-recipes'
  gem 'susy'

  gem "less-rails"
  gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
  gem 'jasny-bootstrap-extension-rails', '0.0.2',
    :path => 'vendor/jasny-bootstrap-extension-rails/'
end

gem 'jquery-rails'
gem 'jquery-migrate-rails'

group :development do
  gem 'foreman'

  gem 'pry'
  gem 'pry-doc'

  gem 'contao'
  gem 'capistrano-contao'
  gem 'capistrano-exts', '>=1.13.2', :require => false
end

group :development, :test do
  gem 'jasmine-rails'
  gem 'jasmine-headless-webkit', '>= 0.9.0.rc2'
  gem 'jasmine-spec-extras'
end