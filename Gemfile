source 'https://rubygems.org'

gem 'rails', '3.2.8'

gem 'sqlite3'
gem 'activerecord-jdbcsqlite3-adapter'

group :production do 
	# Use unicorn with nginx for web server
	gem 'unicorn'
	gem 'postgres-pr' # Production
	gem 'activerecord-postgresql-adapter'
	#gem 'capistrano'
	gem 'rvm-capistrano'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'twitter-bootstrap-rails'
gem 'acts-as-taggable-on'
gem 'carrierwave'
gem 'mini_magick'
gem 'simple_form'
gem 'will_paginate'