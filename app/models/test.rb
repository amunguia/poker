load 'card.rb'
load 'hand.rb'
class Test


def test(array, expected)
puts "testing -------------"


myhand = Hand.new(array);
myhand.best_hand

myhand.printcard(myhand.besthand)
pass = (expected==myhand.bestscore)
puts "\n#{pass}\tscore : #{myhand.bestscore}"




end

end

test = Test.new

cards = Array.new
cards[0] = Card.new('13','S');
cards[1] = Card.new('10','S');
cards[2] = Card.new('6','H');
cards[3] = Card.new('2','S');
cards[4] = Card.new('9','D');
cards[5] = Card.new('14','C');
cards[6] = Card.new('10','C');

test.test(cards, 10.26)

cards = Array.new
cards[0] = Card.new('9','S');
cards[1] = Card.new('14','S');
cards[2] = Card.new('6','H');
cards[3] = Card.new('2','S');
cards[4] = Card.new('9','D');
cards[5] = Card.new('14','C');
cards[6] = Card.new('10','C');

test.test(cards, 10.26)
