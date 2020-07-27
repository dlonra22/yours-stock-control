class UsersController < ApplicationController

  get "/login" do
    #show error if already logged in
    erb :login 
  end
  
  post "/login" do
    user = User.find_by(username: params[:username])
    puts user.password
    if user && user.authenticate(params[:password])
      puts "i'm in"
      session[:user_id] = user.id
      puts current_user.id
      redirect "users/#{user.id}"
    
    else
      #show error message
      puts "im not in"
      puts User.all
      redirect "/login"
    end 
  end
  
  get 'users/:id' do 
    @user = User.find_by_id(current_user.id)
    puts @user
    erb :"users/home"
    
  end
  
  get "/register" do
  #check is user is already logged in, if so redirect to users/new
   if User.all.empty?
      @appregister = true #sends a status check to the register true = first registration of app/ no users in database
      erb:register 
   else 
     redirect "/login"
   end
  end
  
   post "/register" do
     "Hey you registered"
     User.create(params)
     user = User.find_by(username: params[:username])
     session[:user_id] = user.id
     redirect "users/#{user.id}"
   end
  

  
  
  get "/users" do #only admins
    @users = User.all
    @user = User.find_by_id(params[:id])
    if @user.is_admin
    #erb : allusers 
    else
      erb :notadmin
    end
  end

  # GET: /users/new
  get "/users/new" do
     @appregister = false
    erb :register
   end

  # POST: /users
  post "/user/:id/users" do
    redirect "/users"
  end


  # GET: /users/5/edit
  get "/users/:id/edit" do
   # erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    #redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
   # redirect "/users"
  end
end
