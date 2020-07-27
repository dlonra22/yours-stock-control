require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, SecureRandom.hex(64)
  end
  
  get "/" do
    #if already logged in redirect to users home page using sessions
    if logged_in?
      redirect "/users/#{current_user.id}"
    elsif User.all.empty?
      redirect "/register"
    else
      erb :login
      redirect "/login"
    end
  end
  
  helpers do
    def current_user(session)
      User.find_by(id: session[:user_id])
    end 
    def is_logged_in?
      current_user ? false : true
    end
  end

end
