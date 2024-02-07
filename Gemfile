source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.0"

gem "rails", "~> 7.0.0"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "jsbundling-rails", "~> 0.1.0"
gem "turbo-rails", "~> 1.3.0"
gem "stimulus-rails", "~> 1.1.0"
gem "cssbundling-rails", ">= 0.1.0"
gem "jbuilder", "~> 2.7"
gem "redis", "~> 4.0"
gem "kredis", "~> 1.3"

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem "bootsnap", ">= 1.4.4", require: false
gem "propshaft"
gem "bcrypt", "~> 3.1.7"
gem "image_processing", "~> 1.2"

gem "premailer-rails", "~> 1.11"
gem "iso_country_codes", "~> 0.7.8"
gem "pagy", "~> 5.10"
gem "aws-sdk-s3", require: false
gem "geocoder", "~> 1.8"
gem "local_time", "~> 2.1"
gem "browser", "~> 5.3"
gem "email_reply_parser", "~> 0.5.10"

gem "sidekiq", "~> 6.5"
gem "sidekiq-cron", "~> 1.7"

group :development, :test do
  gem "debug", ">= 1.0.0", platforms: %i[ mri mingw x64_mingw ]
  gem "faker", "~> 2.21"
  gem "dotenv-rails", "~> 2.8"
end

group :development do
  gem "web-console", ">= 4.1.0"
  gem "i18n-debug"
  gem "letter_opener", "~> 1.8"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  gem "webdrivers"
end
