class ItemsController < ApplicationController

  get "/items" do
    erb :"items/allitems"
  end
  
  get "/items/new" do
    if logged_in? && current_user.is_admin
       erb :"items/newitem"
    elsif logged_in?
       #show error admins only 
       redirect "/users/#{current_user.id}"
     else 
       #please login 
       redirect "/login"
     end
  end
  
  get "/items/:id" do 
    if logged_in?
        @item = Item.find_by(id: params[:id])
        if @item 
          erb :"items/showitem"
        else 
          #item does not exist or deleted 
        end
      else 
        #please login 
        redirect "/login"
      end
  end
  
  post "/items/new" do 
    if logged_in && current_user.is_admin
        item = Item.new
        item.name = params[:name]
        item.description = params[:description]
        item.price = params[:price]
        item.quantity = params[:quantity]
        item.restock_level = params[:restock_level]
        
        if item.save 
          #show your new item has been saved
          redirect "/items/#{item.id}"
        else 
          #show error 
          redirect "/items/new"
        end 
  elsif logged_in?
        #admins only 
        redirect "/users/#{current_user.id}"
    else 
        #please login
        redirect "/login"
    end 
end
