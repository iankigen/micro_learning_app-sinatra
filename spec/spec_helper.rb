# spec/spec_helper.rb
require 'database_cleaner'
require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require './app/controllers/main_controller.rb'


module RSpecMixin
  include Rack::Test::Methods

  def app
    App
  end

end

RSpec.configure do |c|
  c.include RSpecMixin

  c.before(:each) do
    DatabaseCleaner.start
  end

  c.after(:each) do
    DatabaseCleaner.clean
  end
end

