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
    if logged_in?
      @user = User.find_by_id(params[:id])
      if @user.id == current_user.id
        erb :"users/home"
      else 
        #showerror
      end
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
          end 
        else 
          #show error that user cannot be found 
        end 
    else
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
        puts " I am saved !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        if user.id == current_user.id 
          redirect "/users/#{user.id}"
        elsif current_user.is_admin 
          redirect "/allusers"
        end
      else 
        puts "its an error???????????????????????????????????????????????????"
        #show error 
      end
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
     user.password_confirmation = params[:password_confirmation]
     user.is_admin = true
     if user.save
        session[:user_id] = user.id
        redirect "/users/#{user.id}"
     else 
       #show error messages
     end
   end
   
  get "/allusers/new" do
    if logged_in? && current_user.is_admin
      erb :"users/addnewuser"
    else
      #show error 
      redirect "/"
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
    session.clear
    redirect '/'
  end

  

end
