class Table < ActiveRecord::Base

  has_many :users
  belongs_to :room
  has_one :game

  def new_game
    self.game = Game.new self.min_bet
    self.save
    self.game.id
  end

end
