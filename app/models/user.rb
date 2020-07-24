class User<ActiveRecord::Base 
  has_many :transactions
  has_many :items, through: :transactions
  validates_presence_of :username, :name, :category
  validates :password, :presence => true,
                     :length => { minimum: 6 },
                     :if => lambda{ new_record? || !password.nil? }
  has_secure_password
end