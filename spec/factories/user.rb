require 'bcrypt'

FactoryBot.define do
  factory :users do
    f_name 'test'
    l_name 'user'
    email 'test@site.com'
    password BCrypt::Password.create('password')
  end
end
