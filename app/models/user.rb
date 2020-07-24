class User<ActiveRecord::Base 
  has_many :transactions
  has_many :items, through: :transactions
  has_secure_password
end