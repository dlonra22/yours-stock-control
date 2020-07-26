class UsersController < ApplicationController

  get "/" do
    if User.all.empty?
      redirect "/register"
    else
      erb :login
      redirect "/login"
    end
  end
  
  get "/login"
    erb :login 
  end
  
  get "/register"
   if User.all.empty?
      @appregister = true #sends a status check to the register true = first registration of app/ no users in database
      erb:register 
   else 
     erb :notadmin
     redirect "/login"
   end
  end
  
  post "/login" do
    user = User.find_by(username: params[:username])
    
    if user && user.authenticate(params[:password])
    
    else
      #show error message
      redirect "/login"
    end 
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

  # GET: /users/5
  get "/users/:id" do
   # erb :"/users/show.html"
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
