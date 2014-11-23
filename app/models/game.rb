require 'json'

class Game < ActiveRecord::Base
 
  attr_accessor :id
  
  belongs_to :table
  has_many :users

  def initialize
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
    self.order = "p1,p2,p3,p4"
  end

  def add_player(id)
    if self.p1 == nil
      self.p1 = id
    elsif self.p2 == nil
      self.p2 = id
    elsif self.p3 == nil
      self.p3 = id
    elsif self.p4 == nil
      self.p4 = id
    else
      false
    end
  end

  def cards_for_player(id)
    if self.p1 == nil || self.p2 == nil || self.p3 == nil || self.p4 == nil
      return [] #Game hasn't started, do not reveal cardss
    end

    if self.p1 == id
      self.p1_cards.split ","
    elsif self.p2 == id
      self.p2_cards.split ","
    elsif self.p3 == id
      self.p3_cards.split ","
    elsif self.p4 == id
      self.p4_cards.split ","
    else
      [] 
    end
  end

  def current_player
    if self.current_player == self.p1
      User.find(self.p1)
    elsif self.current_player == self.p2
      User.find(self.p2)
    elsif self.current_player == self.p3
      User.find(self.p3)
    elsif self.current_player == self.p4
      User.find(self.p4)
    else
      nil
    end
  end

  def current_player_str
    self.order.split(",")[0]
  end

  def current_player_folds
    array = self.order.split(",")
    array = array.slice(1, array.length - 1)
    self.order = array.join(",")
    array[0]
  end

  def determine_winner
    #Call codd  
  end

  def is_full?
    !(self.p1 == nil || self.p2 == nil || self.p3 == nil || self.p4 == nil)
  end

  def next_card?
    if self.card1 == nil
      self.reveal_first_three_cards
      true
    elsif self.card4 == nil
      self.reveal_fourth_card
      true
    elsif self.card5 == nil
      self.reveal_fifth_card
      true
    else
      false
    end
  end

  def next_player
    array = self.order.split(",")
    array = array.slice(1, array.length - 1)<< array[0]
    self.order = array.join(",")
    array[0]
  end

  def one_player_left?
    return self.order.split(",").length == 1
  end

  def player_bets(amt)
    if current_player.deduct(amt)
      player_str = current_player_str
      if player_str.eql? "p1"
        self.update p1_contrib: self.p1_contrib + amt
      elsif player_str.eql? "p2"
        self.update p2_contrib: self.p1_contrib + amt
      elsif player_str.eql? "p3"
        self.update p3_contrib: self.p1_contrib + amt
      else
        self.update p4_contrib: self.p1_contrib + amt
      end
    else
      false
    end
  end

  def table_even?
    return self.p1_contrib == self.p2_contrib &&
           self.p3_contrib == self.p4_contrib &&
           self.p1_contrib == self.p3_contrib
  end

  def to_json
    self.save
    self.reload
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
 
    state[:p1_contrib] = p1_contrib
    state[:p2_contrib] = p2_contrib
    state[:p3_contrib] = p3_contrib
    state[:p4_contrib] = p4_contrib
    state[:pot_bal] = self.p1_contrib + self.p2_contrib + self.p3_contrib + self.p4_contrib
    state[:card1] = Deck.card_for_string(self.card1).to_url 
    state[:card2] = Deck.card_for_string(self.card2).to_url
    state[:card3] = Deck.card_for_string(self.card3).to_url
    if self.card4
      state[:card4] = Deck.card_for_string(self.card4).to_url
    else 
      state[:card4] = nil
    end
    if self.card5
      state[:card5] = Deck.card_for_url(self.card5).to_url 
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
  end

  def reveal_fourth_card
    self.card4 = self.stream.split(",")[3]
    self.save
  end

  def reveal_fifth_card
    self.card5 = self.stream.split(",")[4]
    self.save
  end  
end
