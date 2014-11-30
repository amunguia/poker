load 'card.rb'
load 'hand.rb'
class Test


def main
cards = Array.new
cards[0] = Card.new('1','H');
cards[1] = Card.new('1','H');
cards[2] = Card.new('9','H');
cards[3] = Card.new('4','H');
cards[4] = Card.new('5','H');
cards[5] = Card.new('4','S');
cards[6] = Card.new('7','S');


myhand = Hand.new(cards);

myhand.best_hand




end

 

end
Test.new.main
