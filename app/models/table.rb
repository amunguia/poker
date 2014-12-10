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


  def get_usernames

      names = Array.new
      if(self.game == nil)
        return names
      end
      if(self.game.p1 != nil)

        names.push(User.find((self.game.p1).to_i).username)
      end
      if(self.game.p2 != nil)
        names.push(User.find((self.game.p2).to_i).username)
      end
      if(self.game.p3 != nil)
        names.push(User.find((self.game.p3).to_i).username)
      end
      if(self.game.p4 != nil)
        names.push(User.find((self.game.p4).to_i).username)
      end
      names


  end

 def get_status
 	
  	size = (self.get_usernames).size
  	if(size == 4)
      "Playing"
 	 else

  	 "Waiting"
 	 end
 end

end
