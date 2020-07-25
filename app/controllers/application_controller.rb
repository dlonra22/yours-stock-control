require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    if User.all.empty?
      erb :register
    else 
      @users = User.all 
      @admins = User.count(:all, :conditions => "is_admin = true")
      erb :login
    end
  end

end
