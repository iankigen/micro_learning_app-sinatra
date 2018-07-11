require_relative '../spec_helper'

describe 'Authentication' do

  before do
    @user_datails = {
      f_name: 'test',
      l_name: 'user',
      email: 'testuser@site.com',
      password: 'devpassword',
      confirm_password: 'devpassword'
    }

    @invalid_user = {
      f_name: 'invalid',
      l_name: 'user',
      email: '',
      password: '',
      confirm_password: ''
    }
  end
  context 'When user opens register page' do
    it 'should allow accessing register page' do
      get '/register'
      expect(last_response).to be_ok
    end

    it 'should have correct correct last request path' do
      get '/register'
      expect(last_request.path).to eq('/register')
    end
  end

  context 'When user enters correct sign up details' do

    it 'should register successfully' do
      post '/register', @user_datails
      expect(last_response).to be_redirect
    end
  end

  context 'When user enters invalid sign up credentials' do
    it 'should display validation errors when input is incorrect' do
      post '/register', @invalid_user
      expect(last_response.body).to include('Confirm password must be more than 6 characters',
                                            'Invalid email address',
                                            'Email cannot be empty')
    end
  end

  context 'When user opens login page' do
    it 'should allow accessing login page' do
      get '/login'
      expect(last_response).to be_ok
    end

    it 'should have correct correct last request path' do
      get '/login'
      expect(last_request.path).to eq('/login')
    end
  end

  # context 'When user enters correct login details' do
  #
  #   it 'should login successfully' do
  #     post '/login', @user_datails
  #     expect(last_response.body).to eq('sdsd')
  #   end
  # end


end