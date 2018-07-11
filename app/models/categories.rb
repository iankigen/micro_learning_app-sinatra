require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './app/api/news_api'
class Categories < ActiveRecord::Base
  belongs_to :users

  def fetch_articles(user_id)
    news_api = NewsApi.new
    categories = Categories.where(users_id: user_id)
    data = []
    user_categories = []
    if categories
      categories.each do |cat|
        user_categories << cat
        data << news_api.fetch_articles(cat.name)
      end
    end
    data = nil if data.empty?
    user_categories = nil if user_categories.empty?
    [user_categories, data]
  end
end
