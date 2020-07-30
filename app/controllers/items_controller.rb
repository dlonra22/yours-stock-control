class ItemsController < ApplicationController

  # GET: /users/items
  get "/items" do
    erb :"items/allitems"
  end
  
  get "/items/:id" do 
    erb :"items/showitem"
  end

  get "items/new" do
   erb :"items/newitem"
  end

  # POST: users/items
  post "user/:id/items" do
   # redirect "/items"
  end

  # GET: users/items/5
  get "user/:id/items/:iid" do
   # erb :"/items/show.html"
  end

  # GET: users/items/5/edit
  get "user/:id/items/:iid/edit" do
   # erb :"/items/edit.html"
  end

  # PATCH: users/items/5
  patch "user/:id/items/:iid" do
   # redirect "/items/:id"
  end

  # DELETE: delete only admins redirects to items home page
  delete "users/:id/items/:iid/delete" do
   # redirect "/items"
  end
end
