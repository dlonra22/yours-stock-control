require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    register Sinatra::Flash
    enable :sessions
    set :session_secret, "secret"
  end
  
  get "/" do
    #if already logged in redirect to users home page using sessions
    if logged_in?
      flash[:error] = "already logged in"
      redirect "/users/#{current_user.id}"
    elsif User.all.empty?
      flash[:message] = "No users in database please register"
      redirect "/register"
    else
      flash[:message] = "please login"
      redirect "/login"
    end
  end
  
  helpers do
    def current_user
      User.find_by(id: session[:user_id])
    end 
    def logged_in?
      !!current_user
    end
  end

end
