class Game < ActiveRecord::Base
  
  belongs_to :table
  has_many :users
end
