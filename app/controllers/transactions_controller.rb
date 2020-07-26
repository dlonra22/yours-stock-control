class TransactionsController < ApplicationController

  # GET: users/transactions
  get "user/:id/transactions" do
   # erb :"users/transactions/index.html"
  end

  # GET: users/transactions/new
  get "user/:id/transactions/new" do
   # erb :"/transactions/new.html"
  end

  # POST: users/transactions
  post "user/:id/transactions" do
  #  redirect "/transactions"
  end

  # GET: transactions show page
  get "user/:id/transactions/:tid" do
 #   erb :"/transactions/show.html"
  end

  # GET: /transactions/5/edit should not be enable to do the below.
  #get "/transactions/:id/edit" do
  #  erb :"/transactions/edit.html"
 # end

  # PATCH: /transactions/5
  #patch "/transactions/:id" do
  #  redirect "/transactions/:id"
 # end

  # DELETE: /transactions/5/delete
  #delete "/transactions/:id/delete" do
  #  redirect "/transactions"
  #end
end
