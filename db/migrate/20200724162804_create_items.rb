class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name 
      t.string :description
      t.integer :quantity
      t.integer :restock_level
    end
  end
end
