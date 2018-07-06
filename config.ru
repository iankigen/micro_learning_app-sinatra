require 'sinatra'

Dir.glob('./app/{controllers, helpers, models}/*.rb').each { |file| require file }


map('/') { run PagesController }
map('/user') { run UserController }
map('/learn') { run CategoriesController }
