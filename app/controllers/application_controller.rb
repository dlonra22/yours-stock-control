require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    if User.all.empty?
      redirect "/user/signup"
    else 
      redirect "/user/login"
    end
  end

end
