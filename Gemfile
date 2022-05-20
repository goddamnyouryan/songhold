source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'dotenv-rails', groups: [:development, :test]
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'slim-rails'
gem 'omniauth-spotify'
# gem 'omniauth-ringcentral', path: '../omniauth-ringcentral'
gem 'omniauth-rails_csrf_protection'
gem 'httparty'
gem 'iso8601'
gem 'youtube-dl.rb'
gem 'ruby-sox'

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails', '~> 5.0.0'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
end
