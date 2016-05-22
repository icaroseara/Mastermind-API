ENV['RACK_ENV'] = 'test'

require 'factory_girl'
require 'faker'
require 'mongoid_cleaner'
require 'pry'
require 'rack/test'

# Load our application
require_relative '../application.rb'

# Load factories
Dir["#{File.dirname(__FILE__)}/spec/factories/*.rb"].each { |f| require f }

# Defining the app to test is required for rack-test
OUTER_APP = Rack::Builder.parse_file('config.ru').first

# Base URL constant for our future tests
BASE_URL = 'http://example.org:80/api/v1'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # We put this to use create & build directly
  # without using the prefix FactoryGirl
  config.include FactoryGirl::Syntax::Methods

  # Setup Mongoid Cleaner to clean everything before
  # and between each test
  config.before(:suite) do
    MongoidCleaner.strategy = :drop
  end

  config.around(:each) do |example|
    MongoidCleaner.cleaning do
      example.run
    end
  end
end
