#This class defines a single card in the game

class Card

  attr_accessor :number, :suit

  def initialize(number, suit)
    @number = number
    @suit = suit
  end

  def self.for_string(string) #10C
    if string.length == 3
      num = string.slice(0,2)
      suit = string.slice(2,1)
    else
      num = string.slice(0,1)
      suit = string.slice(1,1)
    end
    Card.new num, suit
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
    File.join('cards', "#{@number}#{@suit}.png")    
  end

  def self.url_for card_code
    File.join('cards', card_code+'.png')
  end
  def showcard
   print " #{number} #{suit} ";
  end
end