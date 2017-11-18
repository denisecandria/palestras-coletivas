source 'https://rubygems.org'

ruby '2.4.2'

gem 'rails' , '~> 5.1'
gem 'rails-i18n'
gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'bcrypt', require: 'bcrypt'
gem 'nokogiri', require: false
gem 'multi_json', require: false
gem 'kaminari'
gem 'kaminari-mongoid'
gem 'airbrake', '~> 6.1'
gem 'jbuilder'

gem 'mongoid', '~> 6.1'
gem 'mongoid-slug'
gem 'mongoid_search'
gem 'geocoder'

gem 'sprockets'
gem 'sass-rails'
gem 'bootstrap-sass'
gem 'uglifier'
gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'tinymce-rails'
gem 'tinymce-rails-langs'

gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'
gem 'popper_js', '~> 1.11', '>= 1.11.1'

gem 'puma'

group :development do
  gem 'web-console'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'database_cleaner'
end

group :test do
  gem 'rspec-mocks'
  gem 'webmock'
  gem 'rake'
  gem 'launchy'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'codeclimate-test-reporter'
end

group :production do
  gem 'newrelic_rpm'
  gem 'scout_apm'
end
