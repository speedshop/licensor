source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

gem "rails", "~> 6.0.3", ">= 6.0.3.2"
gem "pg", ">= 0.18", "< 2.0"
gem "puma"
gem "bootsnap", ">= 1.4.2", require: false
gem "aws-sdk-s3"
gem "stripe"
gem "mailgun-ruby"
gem "sentry-raven"
gem "typhoeus"
gem "barnes"

group :development do
  gem "standard"
  gem "rack-mini-profiler"
  gem "stackprof"
  gem "memory_profiler"
end

gem "dotenv-rails", groups: [:development, :test]
