require 'news-api'
require 'byebug'


class CategoriesController < ApplicationController
  get '/learn', auth: :user do
    @page = 'learn'
    @top_headlines = get_news
    erb :'/categories/learn_index'
  end

  get '/learn/add' do
    @page = 'learn'
    erb :'/categories/learn_form'
  end

  post '/learn/add', auth: :user do
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

  get '/sendmail' do


    erb :'/categories/learn_form'
  end

  def user_register_params
    validate_signup_params(params)
  end
end
