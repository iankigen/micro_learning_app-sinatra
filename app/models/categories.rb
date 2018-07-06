require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
class Categories < ActiveRecord::Base
  belongs_to :users
end