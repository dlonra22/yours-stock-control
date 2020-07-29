class UsersController < ApplicationController

  get "/login" do
    #show error if already logged in
    if User.all.empty?
      redirect "/register"
    elsif logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :"users/login"
    end
  end
  
  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "users/#{user.id}"
    else
      #show error message
      redirect "/login"
    end 
  end

  get '/users/:id' do
      @user = User.find_by_id(params[:id])
      erb :"users/home"
  end
  
  get "/allusers" do
    @user = User.find_by_id(current_user.id)
    if @user.is_admin
      @users = User.all
      erb :"users/allusers" 
    else
      #show error
    end
  end
  
  get "/register" do
  #check is user is already logged in, if so redirect to users/admin/new
   if User.all.empty?
      erb :"users/register" 
   elsif logged_in?
     user = User.find_by(id: current_user.id)
     if user.is_admin
       #redirect "users/allusers/new"
     else 
       #showerror message
       #redirect "/users/#{user.id}"
     end
   else
     redirect "/login"
   end
  end
  
   post "/register" do
     user = User.new
     user.username = params[:username]
     user.name = params[:name]
     user.password = params[:password]
     user.is_admin = true
     if user.save
        session[:user_id] = user.id
        redirect "/users/#{user.id}"
     else 
       #show error messages
       redirect "/register"
     end
   end
   
  get '/logout' do
    session.clear
    redirect '/'
  end

  

end
