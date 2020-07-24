class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id 
      t.integer :item_id
      t.string :type 
      t.timestamps
  end
end
