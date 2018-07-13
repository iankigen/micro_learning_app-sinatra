require_relative '../spec_helper'

describe 'Categories' do
  before do
    create(:users)
    @valid_login = {
      email: 'test@site.com',
      password: 'password'
    }
  end


  context 'When user adds a new category' do
    before do
      post '/login', @valid_login
      post '/add-category', name: 'Health'
    end
    it 'should redirect to learn page' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/learn')
    end
  end

  context 'When a non logged user goes to add category page' do
    before do
      get '/add-category'
    end
    it 'should redirect to login page' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/login')
    end
  end

  context 'When a non logged user visits learn page' do
    before do
      get '/learn'
    end
    it 'should redirect to login page' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/login')
    end
  end

  context 'When user with categories visits the learn page' do
    before do
      post '/login', @valid_login
    end
    it 'should fetch articles of that category' do
      get '/add-category'
      expect(last_response.body).to include('Select a category')
      post '/add-category', name: 'Health'
      get '/learn'
      expect(last_response.body).to include('Health',
                                            'author',
                                            'url',
                                            'description')
    end
  end

  context 'When a non logged in user visits delete category page' do
    before do
      get '/delete-category/1'
    end
    it 'should redirect to login page' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/login')
    end
  end

  context 'When a logged in user visits delete category page' do
    before do
      post '/login', @valid_login
      post '/add-category', name: 'Health'
      get "/delete-category/#{Categories.first.id}"
    end
    it 'should redirect to login page' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/learn')
    end
  end
end
