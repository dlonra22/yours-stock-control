class TransactionsController < ApplicationController

get "/mytransactions" do
    if logged_in?
      @transactions = Transaction.all
      @user_trans = [] 
      @transactions.each do |t| 
        @user_trans << t if t.user_id == current_user.id
      end
      erb :mytransactions
    else 
      # please login 
      redirect "/login"
    end
  end
  
  get "/alltransactions" do
    if logged_in?
      @transactions = Transaction.all
      @user_trans = [] 
      @transactions.each do |t| 
        @user_trans << t if t.user_id == current_user.id
      end
      erb :alltransactions
    else 
      # please login 
      redirect "/login"
    end
  end
end
