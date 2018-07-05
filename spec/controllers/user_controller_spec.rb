require File.expand_path '../spec_helper.rb', __dir__
require 'pry'

describe 'Authentication' do
  before do
    @user_sign_up_params = {
      'f_name' => 'Test',
      'l_name' => 'User',
      'email' => 'test@mail.com',
      'password' => 'devpassword',
      'confirm_password' => 'devpassword'
    }
  end
  context 'When a user enters correct credentials' do
    before { post '/register', @user_sign_up_params }
    binding.pry
    it 'should login and redirect successfully' do
      expect(last_response).to be_redirect
    end
  end

  context 'when user enters correct details' do
    before { post '/signup', @user }

    it 'should sign them up successfully' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/')
    end
  end
end