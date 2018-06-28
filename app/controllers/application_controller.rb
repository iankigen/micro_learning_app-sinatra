require 'sinatra'
require 'sinatra/partial'


class ApplicationController < Sinatra::Base
  set :views, File.expand_path('../views', __dir__)
  set public_folder: File.expand_path('../../public', __dir__)
  enable :partial_underscores
  set sessions: true
  register Sinatra::Partial
  set :partial_template_engine, :erb

  not_found { erb :not_found }

  register do
    def auth(type)
      condition do
        redirect '/user/login' unless send("is_#{type}?")
      end
    end
  end


  helpers do
    def is_user?
      @user != nil
    end
  end

  before do
    # @user = Users.get(session[:user])
  end
end
