source 'https://rubygems.org'

gem 'rails', '= 4.2.5.2' # Pinning this so we pick up the security fix to CVE CVE-2016-2098 without jumping to 5

# We need this here so we have a recent enough version that fixes a
# proxy-related bug on asset deploys.
# (See https://github.com/fog/fog/issues/1964.)
gem 'excon'

gem 'asset_sync'
gem 'chef', '= 11.16.2' # pinning this to avoid issues with untrusted self signed certs that come with chef 12
gem 'chef-web-core', :git => 'https://github.com/chef/chef-web-core.git'
gem 'font-awesome-rails', '= 3.1.1.1' # Our styles use this version
gem 'haml'
gem 'config'
gem 'rake'
gem 'requirejs-rails', '= 0.9.8' # pinning this because 0.9.9 (latest as I write this) requires sprockets > 3.0
gem 'responders' # Needed to do respond_to in controllers
                                 # but chef-web-core depends on compass-rails, which requires sprockets < 2.13
gem 'sidekiq', '= 2.5.2' # pinning this to the existing version because of all the sidekiq legacy code
gem 'celluloid', '= 0.12.3' # pinning this to the existing version because of all the sidekiq legacy code
gem 'timers', '= 1.0.1' # pinning this to the existing version because of all the sidekiq legacy code
gem 'redis'
gem 'redis-rails'
gem 'hiredis'
gem 'redis-namespace'
gem 'em-hiredis'
gem 'em-http-request'
gem 'thin', :require => false
gem 'sentry-raven', '~> 2.5'
gem 'secure_headers'
gem 'rubyzip'
gem 'savon'
gem 'kramdown'
gem 'compass-rails'
gem 'newrelic_rpm'
gem 'rest-client', '= 1.6.7' # pinning this to be compatible with chef 11.16.2
gem 'openid_connect'
gem 'rb-readline'

gem 'marketo_chef', git: 'git@github.com:chef/marketo_chef.git', tag: 'v1.0.2'
gem 'veil', git: 'https://github.com/chef/chef_secrets'

group :node do
  gem 'coffee-rails'
  gem 'uglifier'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'capybara-email'
  gem 'poltergeist'
  gem 'byebug'
  gem 'pry'
  gem 'pry-rails'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'mailcatcher'
  gem 'quiet_assets' # Make it so asset requests aren't logged in dev
  gem 'spring' # For app preloading in development
  gem 'spring-commands-rspec'
end

group :production do
  gem 'unicorn-worker-killer', :require => false
  gem 'unicorn', :require => false
end

group :test do
  gem 'timecop' # For using dates/times in tests
end
