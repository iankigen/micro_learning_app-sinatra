require 'sinatra'

Dir.glob('./app/{controllers, helpers, models}/*.rb').each { |file| require file }


use PagesController
use UserController
use CategoriesController

run ApplicationController
