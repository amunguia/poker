class Table < ActiveRecord::Base

  @@mutex = Mutex.new

  has_many :users
  belongs_to :room
  has_one :game

  def get_game #Gets a game for a table, new game if necessary
  	@@mutex.synchronize do
  	  game = self.game
  	  if game.get_winner
        self.game = Game.new self.min_bet
        self.save
        self.game
  	  else
  	    self.game
  	  end
  	end
  end

end
