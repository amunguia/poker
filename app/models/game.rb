require 'json'

class Game < ActiveRecord::Base
 
  attr_accessor :id
  
  belongs_to :table
  has_many :users

  def initialize
    super()
    deck = Deck.new_deck
    self.card1 = deck[0]
    self.card2 = deck[1]
    self.card3 = deck[2]
    self.stream = deck.slice(0,5).join ","
    self.p1_cards = deck.slice(5,2).join ","
    self.p2_cards = deck.slice(7,2).join ","
    self.p3_cards = deck.slice(9,2).join ","
    self.p4_cards = deck.slice(11,2).join ","
  end

  def card_for_player(id)
    if p1 == id
      self.p1_cards.split ","
    elsif p2 == id
      self.p2_cards.split ","
    elsif p3 == id
      self.p3_cards.split ","
    elsif p4 == id
      self.p4_cards.split ","
    else
      [] 
    end
  end
  
  def reveal_first_three_cards
    #implement
  end

  def reveal_fourth_card
    self.card4 = self.stream.split(",")[3]
    self.save
  end

  def reveal_fifth_card
    self.card5 = self.stream.split(",")[4]
    self.save
  end

  def current_player_str
    if self.current_player == self.p1
      "p1"
    elsif self.current_player == self.p2
      "p2"
    elsif self.current_player == self.p3
      "p3"
    elsif self.current_player == self.p4
      "p4"
    end
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
 
    state[:pot_bal] = current_player_str
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
end
