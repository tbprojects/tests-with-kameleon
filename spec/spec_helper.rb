require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'kameleon/ext/rspec/all'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
    config.include FactoryGirl::Syntax::Methods

    # We will clean database fore running all specs
    config.before(:all) do
      DatabaseCleaner.clean_with(:truncation)
    end
  end
end

Spork.each_run do
end