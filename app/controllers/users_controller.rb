class UsersController < ApplicationController

  get "/login" do
    #show error if already logged in
    if User.all.empty?
      #set error no users in system
      redirect "/register"
    elsif logged_in
      #set error you are already logged_in
      redirect "/users/#{current_user.id}"
    else
      erb :"users/login"
    end
  end
  
  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      #set welcome message 
      redirect "users/#{user.id}"
    else
      #set error incorrect credentials 
      redirect "/login"
    end 
  end

  get '/users/:id' do
    if logged_in?
      @user = User.find_by(id: params[:id])
      if @user && (@user.id == current_user.id)
        erb :"users/home"
      else
        #set error you can only access your own home page
        redirect "/users/#{current_user.id}"
      end
    else 
      #set error please login first
      redirect "/login"
    end
  end
  
  get '/users/:id/edit' do
    if logged_in?
        @user = User.find_by(id: params[:id])
        if @user
          if current_user.id == @user.id
              erb :"users/editmyprofile"
          elsif current_user.is_admin
              erb :"users/edituser"
          else 
            #showerror non admin user cannot edit another users profile
            redirect "/users/#{current_user.id}"
          end 
        else 
          #show error that user cannot be found 
           redirect "/users/#{current_user.id}"
        end 
    else
      #set error not logged in
      redirect "/login"
    end
  end
  
  patch "/users/:id" do
       puts params
       user = User.find_by(id: params[:id])
       user.username = params[:username]
       user.name = params[:name]
       user.password = params[:password]
       user.password_confirmation = params[:password_confirmation]
       if params[:is_admin] =="true" || params[:is_admin]=="1" || params[:is_admin] =="on"
            user.is_admin = true
       else 
          user.is_admin =  false 
       end 
      if user.save
        if user.id == current_user.id 
          #set message successfully updated your profile
          redirect "/users/#{user.id}"
        elsif current_user.is_admin 
          #set message you have successfully updated username"
          redirect "/allusers"
        end
      else 
        #set error cannot update 
        redirect "/users/#{params[:id]}/edit"
      end
  end
  
  get "/allusers" do
    if logged_in?
      @user = User.find_by_id(current_user.id)
      if @user.is_admin
        @users = User.all
        erb :"users/allusers" 
      else
        #show error only admins
        redirect "/users/#{current_user.id}"
      end
    else 
      #show error need to login 
      redirect "/login"
  end
  
  #register form for app initilization - when no users in the system - registers an initial admin user"
  get "/register" do
   if User.all.empty?
      erb :"users/register" 
   elsif logged_in?
     user = User.find_by(id: current_user.id)
     if user.is_admin
        #show message you can create users here
        redirect "/allusers/new"
     else 
       #show error only admins can create new users
       redirect "/users/#{user.id}"
     end
   else
     # error please login as admin to add new users
     redirect "/login"
   end
  end
  
   post "/register" do
     user = User.new
     user.username = params[:username]
     user.name = params[:name]
     user.password = params[:password]
     user.password_confirmation = params[:password_confirmation]
     user.is_admin = true
     if user.save
        session[:user_id] = user.id
        #show message you have successfully registered and logged in
        redirect "/users/#{user.id}"
     else 
       #show error messages
       redirect "/register"
     end
   end
   
  get "/allusers/new" do
    if logged_in? && current_user.is_admin
      erb :"users/addnewuser"
    else
      #show error please login/register as an admin
      redirect "/login"
    end
   end

  post "/allusers" do
    user = User.new 
    user.username = params[:username]
    user.name = params[:name]
    user.password = params[:password]
    user.password_confirmation = params[:password_confirmation]
    if params[:is_admin] =="true" || params[:is_admin]=="1"
        user.is_admin = true
    else 
        user.is_admin =  false 
    end 
    if user.save
       #show success message
       redirect "/allusers"
    else
      #show error 
      redirect "/allusers/new"
    end
  end

   
  get '/logout' do
    if logged_in?
      #set message you have successfully logged out 
      session.clear
      redirect '/'
    else 
      #set message - you are not logged in/ your session has timed out
      session.clear
      redirect '/'
    end
  end

  

end
