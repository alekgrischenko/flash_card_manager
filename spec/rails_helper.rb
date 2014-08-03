# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'database_cleaner'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.include Capybara::DSL
  config.include Sorcery::TestHelpers::Rails

  Capybara.javascript_driver = :poltergeist
  Capybara.default_driver = :poltergeist

  config.before :suite do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
 
  config.before type: :request do
    DatabaseCleaner.strategy = :truncation
  end
 
  config.after type: :request  do
    DatabaseCleaner.strategy = :transaction
  end
 
  config.before do
    DatabaseCleaner.start
  end
 
  config.after do
    DatabaseCleaner.clean
  end

end
