require 'sinatra'
require 'sinatra/partial'
require 'sinatra/flash'

Dir.glob('./app/{models}/*.rb').each { |file| require file }
require './app/helpers/init'
class App < Sinatra::Application
  set :views, File.expand_path('../views', __dir__)
  path = File.expand_path('../../public', __dir__)
  set public_folder: path
  enable :partial_underscores
  set sessions: true
  register Sinatra::Flash
  register Sinatra::Partial
  set :partial_template_engine, :erb
  not_found { erb :'shared/not_found' }

  set(:auth) do |type|
    condition do
      redirect '/login' unless send("is_#{type}?")
    end
  end
end
require_relative 'init'
