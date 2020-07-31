class AddColumnsToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :tr_value, :float 
    add_column :transactions, :transaction_notes, :text
  end
end
