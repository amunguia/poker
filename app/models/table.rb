class Table < ActiveRecord::Base

  has_many :users
  belongs_to :room
  has_one :game
end
