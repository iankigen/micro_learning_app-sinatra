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
      password: 'mismatch',
      confirm_password: ''
    }
    @invalid_login = {
      email: '',
      password: ''
    }

    @valid_login = {
      email: 'test@site.com',
      password: 'password'
    }

    @invalid_credentials = {
      email: 'invalid@mail.com',
      password: 'invalid'
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

  context 'When user registers an already existing user' do
    before do
      post '/register', @user_datails
    end
    it 'should return email already exist' do
      post '/register', @user_datails
      expect(last_response.body).to include('Sorry, that email is already taken. Try another?')
    end
  end

  context 'When user enters invalid sign up credentials' do
    it 'should display validation errors when input is incorrect' do
      post '/register', @invalid_user
      expect(last_response.body).to include('Confirm password must be more than 6 characters',
                                            'Invalid email address',
                                            'Email cannot be empty',
                                            'Sorry, Password Mismatch')
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

  context 'When user enters incorrect login details' do

    it 'should give validation errors' do
      post '/login', @invalid_login
      expect(last_response.body).to include('Password cannot be empty',
                                            'Invalid email address',
                                            'Email cannot be empty')
    end
  end

  context 'When user enters correct credentials' do
    it 'should login successfully' do
      create(:users)
      post '/login', @valid_login
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/')
    end
  end

  context 'When user enters invalid credentials without validation errors' do
    it 'should give authentication errors' do
      create(:users)
      post '/login', @invalid_credentials
      expect(last_response.body).to include('Invalid email address or password.')
    end
  end

  context 'When user logs out' do
    before do
      create(:users)
      post '/login', @valid_login
      get '/logout'
    end
    it 'should redirect to login page' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/login')
    end
  end
end