class UsersController < ApplicationController

  get "/login" do
    #show error if already logged in
    if User.all.empty?
      flash[:error] = "No users in database please do initial registration"
      redirect "/register"
    elsif logged_in?
      flash[:error] = "Already logged in!"
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
      flash[:message] = "Welcome Back"
      redirect "/users/#{user.id}"
    else
      #set error incorrect credentials 
      flash[:error] = "Invalid credentials"
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
        flash[:error] = "You can only access your own home page"
        redirect "/users/#{current_user.id}"
      end
    else 
      #set error please login first
      flash[:error] ="Please Log In First"
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
            flash[:error] ="Only Admins Can Edit Other Users"
            redirect "/users/#{current_user.id}"
          end 
        else 
          #show error that user cannot be found 
           flash[:error] = "Cannot find a user by that id"
           redirect "/users/#{current_user.id}"
        end 
    else
      #set error not logged in
      flash[:error] ="Please login first"
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
          flash[:message] ="Profile Successfully Updated!"
          redirect "/users/#{user.id}"
        elsif current_user.is_admin 
          #set message you have successfully updated username"
          flash[:message] = "User #{user.username} has been successfully updated"
          redirect "/allusers"
        end
      else 
        #set error cannot update 
        flash[:error] ="There were update errors. Please try again"
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
        flash[:error] ="Only Admins have access to that page"
        redirect "/users/#{current_user.id}"
      end
    else 
      #show error need to login 
      flash[:error] ="Please log in first"
      redirect "/login"
    end
  end
  
     #register form for app initilization - when no users in the system - registers an initial admin user"
  get "/register" do
   if User.all.empty?
      erb :"users/register" 
   elsif logged_in?
     user = User.find_by(id: current_user.id)
     if user.is_admin
        #show message you can create users here
        flash[:error] = "please create new users here instead"
        redirect "/allusers/new"
     else 
       #show error only admins can create new users
       flash[:error] ="Only admins can create users"
       redirect "/users/#{user.id}"
     end
   else
     # error please login as admin to add new users
     flash[:error] = "Please login as admin to add new users"
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
        flash[:message] = "you have successfully registered and logged in"
        #show message you have successfully registered and logged in
        redirect "/users/#{user.id}"
     else 
       #show error messages
       flash[:error] = "There were some validation errors please ensure your passwords match and 6 or more characters. Ensure all info is complete"
       redirect "/register"
     end
   end
   
  get "/allusers/new" do
    if logged_in? && current_user.is_admin
      erb :"users/addnewuser"
    else
      #show error please login/register as an admin
      flash[:error] ="Please login or register as admin"
      redirect "/login"
    end
  end

  post "/allusers" do
    user = User.new 
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
       #show success message
       flash[:message] ="Successfully created user"
       redirect "/allusers"
    else
      #show error 
      flash[:error] ="There were some validation errors please try again"
      redirect "/allusers/new"
    end
  end

  get '/logout' do
    if logged_in?
      #set message you have successfully logged out 
      flash[:message] = "You have successfully logged out"
      session.clear
      redirect '/'
    else 
      #set message - you are not logged in/ your session has timed out
      flash[:error] ="You are not logged in or your session has timed out"
      session.clear
      redirect '/'
    end
  end 

  delete "/users/:id" do
  	if logged_in?
  		user = User.find_by(id: params[:id])
          if user 
              if user.id == current_user.id
                if user.is_admin
        				admins = []
        				User.all.each do |u| 
        					admins << u.name unless u.is_admin ==false
        				end
                 if admins.count < 2 
                   flash[:error] = "you are the only admin system needs at least one admin - to reset the app choose reset app instead in your management actions - or create another admin user"
                   redirect "/users/#{current_user.id}/edit"
                 else 
                   session.clear 
                   user.destroy 
                   flash[:message] = "message you have successfully deleted your account" 
                   redirect "/"
                 end 
                else 
                 session.clear 
                 user.destroy 
                flash[:message] = "message you have successfully deleted your account" 
                 redirect "/login"
                end
              elsif current_user.is_admin
                user.destroy 
                flash[:message] = "message you have successfully deleted the user" 
                 redirect "/allusers"
              else 
                #show error only admins can delete other users 
                flash[:error] = "Only admins can delete other users" 
                redirect "/users/#{current_user.id}"
              end
          else 
  			flash[:error] = "User does not exist" 
  			redirect "/users/#{current_user.id}"
  		end
      else 
  		flash[:error] = "Please login first"
  		redirect "/login"
      end
  end
  
end
