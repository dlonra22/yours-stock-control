class Item<ActiveRecord::Base 
  has_many :transactions
  validates_presence_of :name, :description, :quantity, :restock_level
  validates_uniqueness_of :name
end