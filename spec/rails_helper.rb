# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'database_cleaner'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'webdrivers/chromedriver'
require 'capybara-screenshot/rspec'
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }


Webdrivers.cache_time = 86_400
SeleniumChrome.setup_driver

Capybara.server = :puma, { Silent: true }
Capybara.javascript_driver = :headless_chrome
Capybara.save_path = "#{ Rails.root }/tmp/screenshots/"

Capybara.raise_server_errors = false
Capybara.default_max_wait_time = 10
Capybara.asset_host = 'http://localhost:3000'
Capybara.configure do |config|
  config.match = :prefer_exact
  config.ignore_hidden_elements = false
  config.visible_text_only = true
  # accept clicking of associated label for checkboxes/radio buttons (css psuedo elements)
  config.automatic_label_click = true
end
Capybara.always_include_port = true


begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
