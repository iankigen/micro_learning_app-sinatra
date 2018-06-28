class UserController < ApplicationController

  get '/login' do
    session[:user] = {
      'name' => 'John Doe',
      'email' => 'john@doe.com'
    }
    erb :user_login
  end

  get '/logout' do
    session[:user_id] = nil
    erb :user_login
  end

  get '/register' do
    erb :user_login
  end
  get '/reset-password', auth: :user do
    erb :user_login
  end

  get '/forgot-password' do
    erb :user_login
  end
end
