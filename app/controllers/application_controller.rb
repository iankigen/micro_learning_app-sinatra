require 'sinatra'
require 'sinatra/partial'
require 'sinatra/flash'
Dir.glob('./app/{models}/*.rb').each { |file| require file }
require './app/helpers/application_helper'

require 'pry'

class ApplicationController < Sinatra::Base
  helpers ApplicationHelpers
  set :views, File.expand_path('../views', __dir__)
  set public_folder: File.expand_path('../../public', __dir__)
  enable :partial_underscores
  set sessions: true
  register Sinatra::Flash
  register Sinatra::Partial
  set :partial_template_engine, :erb
  not_found { erb :'shared/not_found' }

  register do
    def auth(type)
      condition do
        redirect '/user/login' unless send("is_#{type}?")
      end
    end
  end

end
