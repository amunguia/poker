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
#loyal striaght
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
#flush
cards[0] = Card.new('9','H');
cards[1] = Card.new('8','H');
cards[2] = Card.new('12','H');
cards[3] = Card.new('13','H');
cards[4] = Card.new('1','H');
cards[5] = Card.new('4','S');
cards[6] = Card.new('4','S');

test.test(cards, 7.14)
#striaght
cards[0] = Card.new('1','D');
cards[1] = Card.new('2','H');
cards[2] = Card.new('3','D');
cards[3] = Card.new('4','H');
cards[4] = Card.new('5','H');
cards[5] = Card.new('4','S');
cards[6] = Card.new('4','S');

test.test(cards, 6.14)

#three kind
cards[0] = Card.new(' 1','D');
cards[1] = Card.new('1','H');
cards[2] = Card.new('1','D');
cards[3] = Card.new('3','H');
cards[4] = Card.new('2','H');
cards[5] = Card.new('9','S');
cards[6] = Card.new('8','S');

test.test(cards, 5.14)

# two pairs
cards[0] = Card.new('2','D');
cards[1] = Card.new('2','H');
cards[2] = Card.new('3','D');
cards[3] = Card.new('3','H');
cards[4] = Card.new('5','H');
cards[5] = Card.new('4','S');
cards[6] = Card.new('4','S');

test.test(cards, 4.09)




#pair
cards[0] = Card.new('2','D');
cards[1] = Card.new('1','H');
cards[2] = Card.new('3','D');
cards[3] = Card.new('3','H');
cards[4] = Card.new('7','H');
cards[5] = Card.new('4','S');
cards[6] = Card.new('4','S');

test.test(cards, 3.18)


#full house
cards[0] = Card.new('2','D');
cards[1] = Card.new('2','H');
cards[2] = Card.new('1','D');
cards[3] = Card.new('1','H');
cards[4] = Card.new('1','H');
cards[5] = Card.new('4','S');
cards[6] = Card.new('4','S');

test.test(cards, 8.14)

#flush
cards[0] = Card.new('4','H');
cards[1] = Card.new('8','H');
cards[2] = Card.new('3','D');
cards[3] = Card.new('2','H');
cards[4] = Card.new('9','H');
cards[5] = Card.new('13','S');
cards[6] = Card.new('1','H');

test.test(cards, 7.14)
#pair
cards[0] = Card.new('2','H');
cards[1] = Card.new('2','H');
cards[2] = Card.new('1','D');
cards[3] = Card.new('3','H');
cards[4] = Card.new('6','S');
cards[5] = Card.new('7','S');
cards[6] = Card.new('2','D');

test.test(cards, 3.16)

#high card
cards[0] = Card.new('1','H');
cards[1] = Card.new('13','H');
cards[2] = Card.new('2','D');
cards[3] = Card.new('5','H');
cards[4] = Card.new('3','S');
cards[5] = Card.new('6','S');
cards[6] = Card.new('8','D');

test.test(cards, 0.14)



#full house
cards[0] = Card.new('13','H');
cards[1] = Card.new('13','H');
cards[2] = Card.new('13','D');
cards[3] = Card.new('5','H');
cards[4] = Card.new('1','S');
cards[5] = Card.new('1','S');
cards[6] = Card.new('8','D');

test.test(cards, 8.13)

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
cards[0] = Card.new('3','S');
cards[1] = Card.new('1','S');
cards[2] = Card.new('6','H');
cards[3] = Card.new('2','S');
cards[4] = Card.new('9','D');
cards[5] = Card.new('1','C');
cards[6] = Card.new('10','C');

test.test(cards, 10.26)


cards[0] = Card.new('3','S');
cards[1] = Card.new('13','S');
cards[2] = Card.new('6','H');
cards[3] = Card.new('2','S');
cards[4] = Card.new('9','D');
cards[5] = Card.new('13','C');
cards[6] = Card.new('10','C');

test.test(cards, 10.26)







