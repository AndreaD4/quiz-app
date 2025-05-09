source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.2", ">= 7.0.2.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
# gem "puma", "~> 5.0"
gem 'puma', '= 5.6.2'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
# gem "importmap-rails"
# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails", "~> 0.1.0"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails", ">= 0.1.0"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

gem 'haml'
gem 'haml-rails'
gem 'uglifier', '>= 1.3.0'
gem 'aasm'
gem 'devise-security'
gem 'devise-i18n'
gem 'devise-async'
gem 'enumerize'
gem 'money-rails'
gem 'aws-sdk-s3'
gem 'rails-i18n'
gem 'cocoon'
gem 'js-routes'
gem 'delayed_job_active_record'
gem 'prawn'
gem 'prawn-table'
gem 'prawn-icon'
gem 'will_paginate'
gem 'will_paginate-bootstrap-style'
# gem 'rest-client'
gem 'auto_strip_attributes'
gem 'phony_rails'
gem 'validates_overlap'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'codice-fiscale'
gem 'caxlsx'
gem 'caxlsx_rails'
gem 'rest-client', '~> 2.1.0'
gem 'google-apis-calendar_v3', '~> 0.1'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

# gem update --system
# gem install puma -v '5.6.2' --source 'https://rubygems.org/'
# https://stackoverflow.com/questions/71216446/bootstrap-5-1-not-working-in-jsbundling-rails-7
