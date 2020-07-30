class TransactionsController < ApplicationController
  #transaction categories as constants
  SALE = "Sale" 
  STOCK = "Restock"
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
  
  get "/mytransactions/new" do 
    if logged_in?
       @user = User.find_by(id: current_user.id)
       @items_available = Item.all
       if @items_available.count < 1 
         #no items in inventory 
         redirect "/users/#{current_user.id}"
       else
          erb :"transactions/new"
        end
    else
      #please login 
      redirect"/login"
    end
  end
  
  post "/mytransactions/new" do 
        item = Item.find_by(id: params[:item_id].to_i)
        trans_qty = params[:quantity].to_i
        if params[:category] == SALE 
           if item.quantity >= trans_qty
              transaction.quantity = trans_qty
              transaction.category = params[:category]
              transaction.user_id = params[:user_id].to_i
              transaction.item_id = item.id
              item.quantity -= trans_qty
            else
              #show error trans_qty is more than items in stock
              redirect "/mytransactions/new"
            end
        elsif params[:category] == STOCK 
              transaction.quantity = trans_qty
              transaction.category = params[:category]
              transaction.user_id = params[:user_id].to_i
              transaction.item_id = item.id
              item.quantity += trans_qty
        else 
          #show error no transactions of that type available 
          redirect "/mytransactions/new"
        end
        if transaction.save && item.save
           #show message transaction success
           redirect "/mytransactions/:id"
         else 
           #show error transaction failed 
           redirect "/mytransactions/new"
         end
    end
    
  get "/mytransactions/:id" do
    if logged_in?
        @transaction = Transaction.find_by(id: params[:id])
			if @transaction
				  if @transaction.user_id == current_user.id 
  					@item = Item.find_by(id: @transaction.item_id) # may need validating if item is no longer available
  					@user = User.find_by(id: @transaction.user_id) # may need rethinking if users or items have been deleted
					  erb :"transactions/usertransaction"
				  else 
  					#show error this transaction is for a diffect user 
  					redirect "/mytransactions"
				  end
			else 
			  #show error transaction does not exist 
			  redirect "/mytransactions"
			end
    else 
      #show error please log in 
      redirect "/login"
    end 
	end
  
end #end of controller
