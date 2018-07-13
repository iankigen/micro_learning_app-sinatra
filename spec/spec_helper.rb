# spec/spec_helper.rb
require 'database_cleaner'
require 'rack/test'
require 'rspec'
require 'factory_bot'
require 'simplecov'
require 'coveralls'
require 'webmock/rspec'
require 'news-api'

require_relative('mock/news')

Coveralls.wear!

SimpleCov.start

WebMock.disable_net_connect!(allow_localhost: true)

ENV['RACK_ENV'] = 'test'

require './app/controllers/main_controller.rb'

module RSpecMixin
  include Rack::Test::Methods
  include FactoryBot::Syntax::Methods

  def app
    App
  end

end

RSpec.configure do |c|
  c.include RSpecMixin

  c.before(:suite) do
    FactoryBot.find_definitions
  end

  c.before(:each) do
    DatabaseCleaner.start
    news_api_mock = NewsApiMock.new
    allow(News).to receive(:new).and_return news_api_mock
  end

  c.after(:each) do
    DatabaseCleaner.clean
  end
end

