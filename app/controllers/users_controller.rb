class UsersController < ApplicationController

  get "/" do
    if User.all.empty?
      erb :register
    else
      erb :login
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
   # erb :"/users/new.html"
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
