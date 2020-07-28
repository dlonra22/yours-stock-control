class UsersController < ApplicationController

  get "/login" do
    #show error if already logged in
    if User.all.empty?
      redirect "/register"
    elsif logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :login
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
  
  get "/register" do
  #check is user is already logged in, if so redirect to users/admin/new
   if User.all.empty?
      erb :register 
   elsif logged_in?
     user = User.find_by(id: current_user.id)
     if user.is_admin
       redirect "users/allusers/new"
     else 
       #showerror message
       redirect "/users/#{user.id}"
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
     user.is_admin = params[:is_admin]
     if user.save
        session[:user_id] = user.id
        redirect "users/#{user.id}"
     else 
       #show error messages
       redirect "/register"
     end
   end
   
  get "/users/allusers/new" do
   if logged_in?
      user = User.find_by(id: current_user.id)
      if user.is_admin
        erb :addnewuser
      else 
        #show error 
        redirect "users/#{user.id}"
      end 
    else 
      redirect "/login"
    end
  end
  
   post "/users/allusers/new" do
     user = User.new
     user.username = params[:username]
     user.name = params[:name]
     user.password = params[:password]
     user.is_admin = params[:is_admin]
     if user.save
        redirect "users/allusers/#{user.id}"
     else 
       #show error messages
       redirect "/users/allusers/new"
     end
   end
  
  get '/users/:id' do
    if logged_in?
      @user = User.find_by_id(params[:id])
      erb :"users/home"
    else 
      redirect "/login"
    end
  end
  
  
  get "/users/allusers" do #only admins
    @users = User.all
    @user = User.find_by_id(params[:id])
    if @user.is_admin
      #erb : allusers 
    else
      erb :notadmin
    end
  end

  # GET: /users/new
  get "/users/allusers/new" do
    erb :addnewuser
   end

  # POST: /users
 # post "/user/allusers" do
 #   redirect "/users"
  #end


  # GET: /users/5/edit
 # get "/users/:id/edit" do
   # erb :"/users/edit.html"
 # end

  # PATCH: /users/5
 # patch "/users/:id" do
    #redirect "/users/:id"
 # end

  # DELETE: /users/5/delete
  #delete "/users/:id/delete" do
   # redirect "/users"
  #end
end
