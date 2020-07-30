class TransactionsController < ApplicationController

get "/mytransactions" do
    if logged_in?
      transactions = Transaction.all
      @user_trans = [] 
      transactions.each do |t| 
        @user_trans << t if t.user_id == current_user.id
      end
      erb :"transactions/mytransactions"
    else 
      # please login 
      redirect "/login"
    end
  end #end of get mytransactions
  
  get "/alltransactions" do
    if logged_in?
      if current_user.is_admin
        @transactions = Transaction.all
        erb :"transactions/alltransactions"
      else 
        #only admins 
        redirect "/users/#{current_user.id}"
      end
    else 
      # please login 
      redirect "/login"
    end
  end #end of get alltransactions
  
  get "/transactions/new" do 
    erb :"transactions/new"
  end
  
end #end of controller
