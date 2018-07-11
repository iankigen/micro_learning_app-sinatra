require 'sinatra'

Dir.glob('./app/{models}/*.rb').each { |file| require file }

module Sinatra
  module AppHelper
    def is_user?
      begin
        user = Users.find_by_email(session[:user][:email])
        return user if user
      rescue StandardError
        # ignored
      end
      false
    end

    def active_page?(page)
      'active' if page == @page
    end
  end
  helpers AppHelper
end
