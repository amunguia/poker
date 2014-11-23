class User < ActiveRecord::Base
  
  STARTING_BALANCE = 10000
  
  attr_accessor :password, :password_confirmation

  before_save :encrypt_password
  before_save :initial_balance
  before_save :set_level
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  
  def self.authenticate(email, password)f
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def deduct(amt)
    if self.balance > amt
      self.update(balance: self.balance - amt)
    else
      false
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  def initial_balance
    self.balance ||= 1000000
  end

  def set_level
    self.user_level = 1
  end
end
