class PagesController < ApplicationController
  get '/', auth: :user do
    @page = 'home'
    erb :'pages/pages_home'
  end
  get '/about', auth: :user do
    @page = 'about'
    erb :'pages/pages_about'
  end
end