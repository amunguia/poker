require 'json'

class Game < ActiveRecord::Base
 
  
  belongs_to :table

  def initialize(min_bet)
    super()
    deck = Deck.new_deck
    self.stream = deck.slice(0,5).join ","
    self.p1_cards = deck.slice(5,2).join ","
    self.p2_cards = deck.slice(7,2).join ","
    self.p3_cards = deck.slice(9,2).join ","
    self.p4_cards = deck.slice(11,2).join ","
    self.p1_contrib = 0
    self.p2_contrib = 0
    self.p3_contrib = 0
    self.p4_contrib = 0
    self.each_contrib = 0
    self.round_count = 0
    self.players_left = 4
    self.message = ""
    self.min_bet = min_bet
    self.new_round = true
    self.perm_table ||= self.table_id
    self.order = "p1,p2,p3,p4"
  end

  def add_player(id)
    if (p1 == id || p2 == id || p3 == id || p4 == id) 
      return false
    end
    user = User.find(id)

    if self.p1 == nil
      self.p1 = id
      self.current_player = id
      self.message = "#{user.username} joined the game."
      self.save
      "p1"
    elsif self.p2 == nil
      self.p2 = id
      self.message = "#{user.username} joined the game."
      self.save
      "p2"
    elsif self.p3 == nil
      self.p3 = id
      self.message = "#{user.username} joined the game."
      self.save
      "p3"
    elsif self.p4 == nil
      self.p4 = id
      self.message = "#{user.username} joined the game."
      self.save
      "p4"
    else
      false
    end
  end

  def cards_for_player(id)
    if self.p1 == nil || self.p2 == nil || self.p3 == nil || self.p4 == nil
      return [] #Game hasn't started, do not reveal cardss
    end

    if self.p1 == id
      cards = self.p1_cards.split ","
    elsif self.p2 == id
      cards = self.p2_cards.split ","
    elsif self.p3 == id
      cards = self.p3_cards.split ","
    elsif self.p4 == id
      cards = self.p4_cards.split ","
    end

    if cards
      array = []
      array<< Card.url_for(cards[0])
      array<< Card.url_for(cards[1])
      array
    else
      []
    end
  end

  def current_player_obj
    if self.current_player_str == "p1"
      User.find(self.p1)
    elsif self.current_player_str == "p2"
      User.find(self.p2)
    elsif self.current_player_str == "p3"
      User.find(self.p3)
    else self.current_player_str == "p4"
      User.find(self.p4)
    end
  end

  def current_player_str
    self.order.split(",")[0]
  end

  def current_player_folds
    array = self.order.split(",")
    array = array.slice(1, array.length - 1)
    self.order = array.join(",")
    set_current_player array[0]
    self.players_left -= 1
    self.message = "#{current_player_obj.username} folds."
    self.save
    array[0]
  end

  def determine_winner
    #Call codd  
  end

  def get_winner
    if (!next_card? && table_even?) 
      winner_id = calculate_winner
      save
    else
      nil
    end
     #self.winner_id ||= self.p1
     #save
     #table = Table.find self.table_id
     #table.new_game
     #self.winner_id
  end

  def is_full?
    !(self.p1 == nil || self.p2 == nil || self.p3 == nil || self.p4 == nil)
  end

  def is_not_turn(user)
    current_player_obj.id != user.id
  end

  def is_user_in_game?(user)
    if p1 == user.id
      "p1"
    elsif p2 == user.id
      "p2"
    elsif p3 == user.id
      "p3"
    elsif p4 == user.id
      "p4"
    else
      false
    end
  end

  def next_card?
    if self.card1 == nil
      self.reveal_first_three_cards
      self.round_count = 0
      self.new_round = true
      self.save
      true
    elsif self.card4 == nil
      self.reveal_fourth_card
      self.round_count = 0
      self.new_round  = true
      self.save
      true
    elsif self.card5 == nil
      self.reveal_fifth_card
      self.round_count = 0
      self.new_round = true
      self.save
      true
    else
      false
    end
  end

  def next_player
    array = self.order.split(",")
    array = array.slice(1, array.length - 1)<< array[0]
    self.order = array.join(",")
    self.round_count += 1
    set_current_player array[0]
    self.save
    array[0]
  end

  def one_player_left?
    return self.order.split(",").length == 1
  end

  def player_bets(amt)
    player_str = current_player_str
    if player_str.eql? "p1"
      if (p1_contrib + amt) < each_contrib
        return false
      end
    elsif player_str.eql? "p2"
      if (p2_contrib + amt) < each_contrib
        return false
      end
    elsif player_str.eql? "p3"
      if (p3_contrib + amt) < each_contrib
        return false
      end
    elsif player_str.eql? "p4"
      if (p4_contrib + amt) < each_contrib
        return false
      end
    end

    if current_player_obj.deduct(amt)
      if player_str.eql? "p1"
        if (p1_contrib + amt) > each_contrib
          self.update each_contrib: (p1_contrib + amt)
        end
        if new_round && amt > min_bet
            self.update new_round: false
        end
        self.update p1_contrib: self.p1_contrib + amt
        self.update message: "#{current_player_obj.username} bet $#{amt}"
      elsif player_str.eql? "p2"
       if (p2_contrib + amt) > each_contrib
          self.update each_contrib: (p2_contrib + amt)
        end
        if new_round && amt > min_bet
            self.update new_round: false
        end        
        self.update p2_contrib: self.p2_contrib + amt
        self.update message: "#{current_player_obj.username} bet $#{amt}"
      elsif player_str.eql? "p3"
        if (p3_contrib + amt) > each_contrib
          self.update each_contrib: (p3_contrib + amt)
        end        
        if new_round && amt > min_bet
            self.update new_round: false
        end        
        self.update p3_contrib: self.p3_contrib + amt
        self.update message: "#{current_player_obj.username} bet $#{amt}"
      else
        if (p4_contrib + amt) > each_contrib
          self.update each_contrib: (p4_contrib + amt)
        end 
        if new_round && amt > min_bet
            self.update new_round: false
        end        
        self.update p4_contrib: self.p4_contrib + amt  
        self.update message: "#{current_player_obj.username} bet $#{amt}"     
      end
    else
      false
    end
  end

  def set_current_player(string)
    if string.eql? "p1"
      self.current_player = self.p1
    elsif string.eql? "p2"
      self.current_player = self.p2
    elsif string.eql? "p3"
      self.current_player = self.p3
    else
      self.current_player =self.p4
    end
  end

  def table_even?
    if self.round_count < self.players_left 
      return false
    end

    match = -1

    self.order.split(",").each do |p|
      if p.eql? "p1"
        contrib = self.p1_contrib
      elsif p.eql? "p2"
        contrib = self.p2_contrib
      elsif p.eql? "p3"
        contrib = self.p3_contrib
      else
        contrib = self.p4_contrib
      end
    
      if match < 0
        match = contrib
      elsif match != contrib
        return false
      end
    end
    true
  end

  def valid_player(user)
    user.id == p1 || user.id == p2 || user.id == p3 || user.id == p4
  end

  def to_json()
    self.save
    self.reload
    state  = {}
    users = {}
    
    if self.p1
      player = User.find_by_id(self.p1)
      object = {:username => player.username, :balance => player.balance}
      users["p1"] = object
    else
      users["p1"] = {:username => "----", :balance => "----"}
    end

    if self.p2
      player = User.find_by_id(self.p2)
      object = {:username => player.username, :balance => player.balance}
      users["p2"] = object
    else
      users["p2"] = {:username => "----", :balance => "----"}
    end

    if self.p3
      player = User.find_by_id(self.p3)
      object = {:username => player.username, :balance => player.balance}
      users["p3"] = object
    else
      users["p3"] = {:username => "----", :balance => "----"}
    end

    if self.p4
      player = User.find_by_id(self.p4)
      object = {:username => player.username, :balance => player.balance}
      users["p4"] = object
    else
      users["p4"] = {:username => "----", :balance => "----"}
    end
 
    state[:started] = is_full?
    state[:users] = users
    state[:current_player] = current_player_str
    state[:message] = message
    state[:new_round] = new_round
    state[:min_bet] = get_min_bet
    state[:each_contrib] = each_contrib
    state[:p1_contrib] = p1_contrib
    state[:p2_contrib] = p2_contrib
    state[:p3_contrib] = p3_contrib
    state[:p4_contrib] = p4_contrib
    state[:result] = true
    state[:pot_bal] = self.p1_contrib + self.p2_contrib + self.p3_contrib + self.p4_contrib
    if (card1) 
      state[:card1] = Deck.card_for_string(self.card1).to_url 
    else
      state[:card1] = nil
    end
    if (card2) 
      state[:card2] = Deck.card_for_string(self.card2).to_url 
    else
      state[:card2] = nil
    end
    if (card3) 
      state[:card3] = Deck.card_for_string(self.card3).to_url 
    else
      state[:card3] = nil
    end
    if (card4) 
      state[:card4] = Deck.card_for_string(self.card4).to_url 
    else
      state[:card4] = nil
    end
    if (card5) 
      state[:card5] = Deck.card_for_string(self.card5).to_url 
    else
      state[:card5] = nil
    end
    state.to_json
  end

 
  def self.get_users
    users = []
    users<< (User.new email: 'aaaaa12', username: 'aaaaa1', password: 'aa', password_confirmation: 'aa')
    users<< (User.new email: 'bbbbb12', username: 'bbbbb1', password: 'bb', password_confirmation: 'bb')
    users<< (User.new email: 'ccccc12', username: 'ccccc1', password: 'cc', password_confirmation: 'cc')
    users<< (User.new email: 'ddddd12', username: 'ddddd1', password: 'dd', password_confirmation: 'dd')
    users<< (User.new email: 'eeeee12', username: 'eeeee1', password: 'ee', password_confirmation: 'ee')
    
    users
  end


  def reveal_first_three_cards
    self.card1 = self.stream.split(",")[0]
    self.card2 = self.stream.split(",")[1]
    self.card3 = self.stream.split(",")[2]
    self.message = "The stream is shown."
    self.save
  end

  def reveal_fourth_card
    self.card4 = self.stream.split(",")[3]
    self.message = "The turn is shown."
    self.save
  end

  def reveal_fifth_card
    self.card5 = self.stream.split(",")[4]
    self.message = "The river is shown."
    self.save
  end  

  def get_min_bet
    if new_round 
      min_bet
    else
      player = current_player_str
      if player.eql? "p1"
        each_contrib - p1_contrib
      elsif player.eql? "p2"
        each_contrib - p2_contrib
      elsif player.eql? "p3"
        each_contrib - p3_contrib
      else
        each_contrib - p4_contrib
      end
    end
  end

  def calculate_winner
    p1
  end
end