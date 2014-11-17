require 'json'

class Game < ActiveRecord::Base
  
  belongs_to :table
  has_many :users

  def initialize
    #Set cards
  end

  def to_json
    state  = {}
    
    if self.p1
      player = User.find_by_id(self.p1)
      state[:p1_username] = player.username
      state[:p1_bal] = player.balance
    else
      state[:p1_username] = "--"
      state[:p1_bal] = "--"
    end

    if self.p2
      player = User.find_by_id(self.p2)
      state[:p2_username] = player.username
      state[:p2_bal] = player.balance
    else
      state[:p2_username] = "--"
      state[:p2_bal] = "--"
    end

    if self.p3
      player = User.find_by_id(self.p3)
      state[:p3_username] = player.username
      state[:p3_bal] = player.balance
    else
      state[:p3_username] = "--"
      state[:p3_bal] = "--"
    end

    if self.p4
      player = User.find_by_id(self.p4)
      state[:p4_username] = player.username
      state[:p4_bal] = player.balance
    else
      state[:p4_username] = "--"
      state[:p4_bal] = "--"
    end
 
    state[:pot_bal] = self.current_bal
    state[:turn] = do
      if self.current_player == self.p1
        "p1"
      elsif self.current_player == self.p2
        "p2"
      elsif self.current_player == self.p3
        "p3"
      else
        "p4"
      end 
    end

    state[:card1] = self.card1
    state[:card2] = self.card2
    state[:card3] = self.card3
    state[:card4] = self.card4
    state[:card5] = self.card5

    
 
    state.to_json
  end
end
