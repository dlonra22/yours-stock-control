class AddColumnsToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :value, :float 
    add_column :transactions, :transaction_notes, :text
  end
end
