class ItemsController < ApplicationController

  # GET: /users/items
  get "users/items" do
    #erb :"users/items/index.html"
  end


  # GET: /users/items/new only for admins
  get "users/items/new" do
   # erb :"/items/new.html"
  end

  # POST: users/items
  post "users/items" do
   # redirect "/items"
  end

  # GET: users/items/5
  get "users/items/:id" do
   # erb :"/items/show.html"
  end

  # GET: users/items/5/edit
  get "users/items/:id/edit" do
   # erb :"/items/edit.html"
  end

  # PATCH: users/items/5
  patch "users/items/:id" do
   # redirect "/items/:id"
  end

  # DELETE: users/items/5/delete only admins
  delete "users/items/:id/delete" do
   # redirect "/items"
  end
end
