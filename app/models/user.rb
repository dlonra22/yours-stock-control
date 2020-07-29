class User<ActiveRecord::Base 
  has_many :transactions
  has_many :items, through: :transactions
  validates_presence_of :username, :name
  #validates_uniqueness_of :username
  #validates_confirmation_of :password,  message: 'Passwords Should Match'
  #validates_presence_of :password_confirmation, if: :password_digest_changed?

  validates :password, :presence => true,
                     :length => { minimum: 6 },
                     :if => lambda{ new_record? || !password.nil? }
  has_secure_password
end