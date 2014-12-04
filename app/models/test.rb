load 'card.rb'
load 'hand.rb'

class Test


def main
puts "testing -------------"
cards = Array.new
cards[0] = Card.new('4','H');
cards[1] = Card.new('2','H');
cards[2] = Card.new('2','H');
cards[3] = Card.new('2','H');
cards[4] = Card.new('4','H');
cards[5] = Card.new('4','S');
cards[6] = Card.new('5','S');


myhand = Hand.new(cards);
myhand.best_hand
puts "my card : ----" 
myhand.printcard(myhand.mycards)
puts 
puts "---------"
myhand.combination.each do |item|
myhand.printcard(item)
puts
end
puts " best hand ---"
myhand.printcard(myhand.besthand)
puts "score : #{myhand.bestscore}"




end

 

end
Test.new.main

