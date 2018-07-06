require 'news-api'

class CategoriesController < ApplicationController
  get '/', auth: :user do
    @page = 'learn'
    newsapi = News.new('77cf0019ddac41acb887527a1c06111c')

    user = Users.find_by(email = session[:user]['email'])
    categories = Categories.find_by(users_id: user.id)

    @top_headlines = newsapi.get_top_headlines(q: categories.name,
                                               language: 'en',
                                               page: 1,
                                               sortBy: 'popularity')

    erb :'/categories/learn_index'
  end

  get '/add' do
    @page = 'learn'
    erb :'/categories/learn_form'
  end

  post '/add', auth: :user do
    @page = 'learn'
    @category = Categories.new(params)
    user = is_user? if is_user?
    @category.users = user
    if @category.save
      redirect '/'
    else
      erb :'/categories/learn_form'
    end
  end

  put '/' do
    # session[:user] = nil
    erb :'/categories/learn_form'
  end

  def user_register_params
    validate_signup_params(params)
  end
end
