require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'simplecov'
SimpleCov.start "rails" if ENV["COVERAGE"]

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false

  config.order = "random"

  require 'database_cleaner'

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = "mongoid"
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end

  config.include SpecHelpers

  config.include FactoryGirl::Syntax::Methods

  config.include Capybara::DSL

  Capybara.javascript_driver = :webkit

  Mongoid.logger.level = Logger::INFO

  Geocoder.configure(:lookup => :test)

  Geocoder::Lookup::Test.set_default_stub(
    [
      {
        'geometry'     => {'location' => {'lat' => -1.4714916, 'lng' => -48.4945471}},
        'address'      => 'Rua dos Caripunas, 400, Jurunas, Belém, Pará, Brasil',
        'state'        => 'Pará',
        'state_code'   => 'PA',
        'country'      => 'Brazil',
        'country_code' => 'BR'
      }
    ]
  )
end
