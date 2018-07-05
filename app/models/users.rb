require 'bcrypt'
require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
class Users < ActiveRecord::Base

  def set_password=(new_password)
    self.password = BCrypt::Password.create(new_password)
  end

  def confirm_password(password)
    correct_password = BCrypt::Password.new(self.password)
    correct_password == password
  end

end