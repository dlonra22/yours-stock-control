class ItemsController < ApplicationController

  # GET: /users/items
  get "user/:id/items" do
    #erb :"users/items/index.html"
  end


  # GET: /users/items/new only for admins
  get "user/:id/items/new" do
   # erb :"/items/new.html"
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
