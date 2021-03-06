class Transaction<ActiveRecord::Base
  belongs_to :item 
  belongs_to :user
  validates_presence_of :user_id, :item_id, :category, :quantity
end