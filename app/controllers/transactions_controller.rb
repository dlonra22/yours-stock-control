class TransactionsController < ApplicationController

  # GET: /transactions
  get "/transactions" do
    erb :"/transactions/index.html"
  end

  # GET: /transactions/new
  get "/transactions/new" do
    erb :"/transactions/new.html"
  end

  # POST: /transactions
  post "/transactions" do
    redirect "/transactions"
  end

  # GET: /transactions/5
  get "/transactions/:id" do
    erb :"/transactions/show.html"
  end

  # GET: /transactions/5/edit should not be enable
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
