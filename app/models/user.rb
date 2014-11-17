class User < ActiveRecord::Base
  STARTING_BALANCE = 10000
  
  attr_accessor :id, :password, :password_confirmation
  belongs_to :room
  belongs_to :table
  belongs_to :game

  before_save :encrypt_password
  before_save :initial_balance
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  def initial_balance
    self.balance = STARTING_BALANCE
  end
  

end
