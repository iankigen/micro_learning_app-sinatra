class UserController < ApplicationController
  get '/login' do
    @page = 'login'
    @values = display_login_values
    @errors = display_login_errors
    erb :'/user/user_login'
  end

  post '/login' do
    @page = 'login'
    data = validate_login_params(params)
    @errors = data.first.first
    @values = data.first.last
    user_params = data.last
    if @errors == display_login_errors

      if handle_sessions(user_params)
        redirect '/'
      else
        @errors['msg'] = 'Invalid email address or password.'
      end
    end
    erb :'/user/user_login'
  end

  get '/logout', auth: :user do
    session[:user] = nil
    redirect '/user/login'
  end

  get '/register' do
    @page = 'register'
    @errors = display_signup_errors
    @values = display_signup_values
    erb :'/user/user_register'
  end

  post '/register' do
    @page = 'register'
    data = user_register_params
    @errors = data.first.first
    @values = data.first.last
    user_params = data.last
    @user = Users.new(user_params)
    @user.set_password = params[:password]

    if @errors == display_signup_errors
      if @user.save
        flash.next[:success] = {
          msg: 'Registration successful. Please Login'
        }
        redirect '/user/login'
      end
    end
    erb :'/user/user_register'
  end

  get '/reset-password', auth: :user do
    @page = 'reset-password'
    erb :'/user/user_reset_password'
  end

  get '/forgot-password' do
    @page = 'forgot-password'
    erb :'/user/user_forgot_password'
  end

  def user_register_params
    validate_signup_params(params)
  end
end
