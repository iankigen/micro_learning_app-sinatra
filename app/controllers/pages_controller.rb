require 'sinatra'

Dir.glob('./app/{models}/*.rb').each { |file| require file }
class App < Sinatra::Application
  get '/', auth: :user do
    @page = 'home'
    erb :'pages/pages_home'
  end
  get '/about', auth: :user do
    @page = 'about'
    erb :'pages/pages_about'
  end
end