require_relative '../spec_helper'

describe 'Pages' do
  before do
    create(:users)
    @valid_login = {
      email: 'test@site.com',
      password: 'password'
    }
  end


  context 'When a logged in user goes to the home page' do
    before do
      post '/login', @valid_login
      get '/'
    end
    it 'should load successfully' do
      expect(last_response).to be_ok
      expect(last_response.body).to include('Welcome back test !')
    end
  end

  context 'When a logged in user goes to the about page' do
    before do
      post '/login', @valid_login
      get '/about'
    end
    it 'should load successfully' do
      expect(last_response).to be_ok
      expect(last_response.body).to include('Micro Learning App')
    end
  end

  context 'When a non logged user visits home page' do
    before do
      get '/'
    end
    it 'should redirect to login page' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/login')
    end
  end

  context 'When a non logged user visits about page' do
    before do
      get '/about'
    end
    it 'should redirect to login page' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/login')
    end
  end

end
