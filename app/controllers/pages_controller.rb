class PagesController < ApplicationController


  layout 'pages_layout'

  get '/' do
    @name = 'ian'
    erb :pages_home
  end
  get '/about' do
    erb :pages_about
  end
end