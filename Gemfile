# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'bootsnap', require: false
gem 'dry-monads'
gem 'dry-rails'
gem 'httparty'
gem 'puma'
gem 'rails'
gem 'redcarpet'
gem 'sass-rails'

group :test do
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  gem 'spring-watcher-listen'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'rubocop'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
