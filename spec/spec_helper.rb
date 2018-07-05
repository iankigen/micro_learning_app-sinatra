# spec/spec_helper.rb
require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

Dir.glob('./app/{controllers}/*.rb').each { |file| require file }


module RSpecMixin
  include Rack::Test::Methods

  def app
    PagesController
  end

end

RSpec.configure do |c|
  c.include RSpecMixin
end

