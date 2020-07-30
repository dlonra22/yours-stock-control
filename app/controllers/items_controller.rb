class ItemsController < ApplicationController

  # GET: /users/items
  get "/items" do
    erb :"items/allitems"
  end
  
  get "/items/new" do
   erb :"items/newitem"
  end
  
  get "/items/:id" do 
    erb :"items/showitem"
  end

end
