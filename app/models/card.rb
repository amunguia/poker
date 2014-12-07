#This class defines a single card in the game

class Card

  attr_accessor :number, :suit

  def initialize(number, suit)
    @number = number
    @suit = suit
  end

  def to_s
    "#{@number}#{@suit}"
  end
  
  def get_dec
    if @suit.eql? "H"
      4
    elsif @suit.eql? "D"
      3
    elsif @suit.eql? "S"
      2
    else
      1
    end
  end

  def to_url
    File.join('assets', 'cards', "#{@number}#{@suit}.png")    
  end

  def self.url_for card_code
    File.join('assets', 'cards', card_code+'.png')
  end
  def showcard
   print " #{number} #{suit} ";
  end
end