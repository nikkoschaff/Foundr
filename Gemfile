source 'https://rubygems.org'

gem 'rails', '3.2.8'

gem 'thin' # Better webserver

group :development do 
	gem 'sqlite3'
end

group :production do 
	gem 'pg'
	gem 'postgres-pr'
	gem 'activerecord-postgresql-adapter'
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
