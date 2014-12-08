class Table < ActiveRecord::Base

  @@mutex = Mutex.new

  has_many :user
  has_many :chat
  belongs_to :room
  has_one :game

  def get_game 
    self.game
  end

  def new_game
    self.game = Game.new self.min_bet
  end

end
