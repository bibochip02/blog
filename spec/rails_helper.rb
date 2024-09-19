require 'spec_helper'
ENV["RAILS_ENV"] ||= "test"
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"


Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

ActiveRecord::Migration.maintain_test_schema!
SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::LcovFormatter,
  SimpleCov::Formatter::CoberturaFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  enable_coverage(:branch)
end

Coveralls.wear!('rails')

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
