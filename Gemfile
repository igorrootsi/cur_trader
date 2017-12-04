source 'https://rubygems.org'

ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap', '~> 4.0.0.beta2.1'
gem 'jquery-rails'

gem 'chartkick'
gem 'devise', '~> 4.3'
gem 'draper'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'rest-client', '~> 2.0', '>= 2.0.2'
gem 'sass-rails', '~> 5.0'
gem 'sidekiq'
gem 'slim'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'guard-rspec', require: false
  gem 'rspec-rails', '~> 3.7', '>= 3.7.2'
  gem 'selenium-webdriver'
end

group :test do
  gem 'database_cleaner'
  gem 'rspec-its'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', require: false
end

group :development do
  gem 'debase', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rcodetools', github: 'rcodetools', branch: :master, require: false
  gem 'rdoc', require: false
  gem 'rubocop', require: false
  gem 'ruby-debug-ide', require: false
  gem 'slim_lint', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
