require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, SecureRandom.hex(64)
  end
  
  Helpers do
    def current_user(session)
      User.find_by(id: session[:user_id])
    end 
    def is_logged_in?
    end
  end

end
