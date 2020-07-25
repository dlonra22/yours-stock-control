class TransactionsController < ApplicationController

  # GET: users/transactions
  get "users/transactions" do
    erb :"users/transactions/index.html"
  end

  # GET: users/transactions/new
  get "users/transactions/new" do
    erb :"/transactions/new.html"
  end

  # POST: users/transactions
  post "/transactions" do
    redirect "/transactions"
  end

  # GET: users/transactions/5
  get "users/transactions/:id" do
    erb :"/transactions/show.html"
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
