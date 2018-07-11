require 'sinatra'

Dir.glob('./app/{models}/*.rb').each { |file| require file }
class App < Sinatra::Application
  get '/learn', auth: :user do
    @page = 'learn'
    user = Users.find_by_email(session[:user][:email])
    @category = Categories.new
    res = @category.fetch_articles(user.id)
    @categories = res.first
    @top_headlines = res.last
    erb :'/categories/learn_index'
  end

  get '/add-category', auth: :user do
    @page = 'learn'
    erb :'/categories/learn_form'
  end

  get '/delete-category/:id', auth: :user do
    id = params[:id]
    @category = Categories.find(id)
    @category.destroy
    redirect '/learn'
  end

  post '/add-category', auth: :user do
    @page = 'learn'
    @category = Categories.new(params)
    user = is_user? if is_user?
    @category.users = user
    if @category.save
      redirect '/learn'
    else
      erb :'/categories/learn_form'
    end
  end
end