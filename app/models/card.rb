#This class defines a single card in the game

class Card

  def initialize(number, suit)
    @number = number
    @suit = suit
  end

  def to_s
    "#{@number}#{@suit}"
  end

  def as_url
    Rails.root.join('app', 'assets', 'images', 'cards', "#{@number}#{@suit}.png")    
  end
end
