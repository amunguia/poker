class Hand
  
  attr_accessor :cards, :mycards,:besthand,:combination,:bestscore
  
  def initialize(cards)
      @cards = cards
      @mycards = Array.new
      @besthand
      @bestscore
     
      
  end

 def set_up
      2.times{|i = 0| @mycards[i] = @cards[i]} #remember first two cards
      @cards.delete_at(0)
      @cards.delete_at(0) #remove these remembered cards
      @combination = @cards.combination(3).to_a # get all combinations of picking 3 cards froom 5 cards 
      @combination.each do |item|
      item.concat(@mycards) #we must use these remembered 2 cards, so we concat with these combination of 3 cards
      item.sort_by!{|a| a.number.to_i}
      end
    # @cards.sort_by!{|item| item.number.to_i}
   # b = a.group_by { |h| h[:name] }.values.select { |a| a.size > 1 }.flatten
  # puts "#{@combination[0]}"
 # b = @combination[0].uniq { |e| e.number }
  # puts " b :   #{@combination[0] - b}"
   

 end

  def best_hand
  self.set_up
 
  i = 0
  scores = Array.new
  @combination.each do |item|
  
    score = 0
  if((score = straight_flush(item)) > 0)
        
  elsif (score =four_kind(item)) > 0
        
  elsif (score =full_house(item)) > 0
         
  elsif (score = flush(item)) > 0
         
  elsif (score =three_kind(item)) >0
  	
  elsif (score =two_pair(item)) > 0
        
  elsif (score =pair(item)) > 0
       
  else
        score = high_card(item) / 100.0
  end
       scores[i] = score
       i += 1
  end
       @bestscore = scores.max
       max = scores.index(@bestscore)
       @besthand = @combination[max]
     
  end

    
  def straight_flush(set)
    if straight(set) > 0 && flush(set) > 0
      return 10 + high_card(set).to_i / 100.0 + (set[3].number.to_i / 100.0)
    end
    return 0
  end

 def flush(set)
 suit = set[0].suit
  set.each do|item|
     if(suit != item.suit)
	return 0
      end 
  end
 return 6.0 + high_card(set).to_i / 100.0
 end


 def straight(set)
     first = set[0].number.to_i
     check = 0
     if(first == 1 && set[1].number.to_i == 10)
         check = 1
         frist = 10
         i = 0
	set[1..4].each do |item|
       
        if(frist + i != item.number.to_i)
            break
        end
        i += 1
        end
        if(i == 4)
           return 5 + high_card(set).to_i / 100.0 + set[3].number.to_i / 100.0
        end



	
     end
     
     i = 0
     set.each do |item |
     if(first + i != item.number.to_i)
       return 0
     end
     i +=1
    end
    
    return 5 + high_card(set).to_i / 100.0
 end
 def four_kind(set)
 uniq = set.uniq {|e| e.number}
 if(uniq.size == 2)
 repeat = set - uniq
 head = repeat[0].number.to_i
 repeat.each do |item|
     if head != item.number.to_i
     return 0
     end
   
 end
 if(head == 1 )
  head = 14
 end
 return 8 + head / 100.0

 end
return 0
 end

def full_house(set)
uniq = set.uniq {|e| e.number}
repeat = set - uniq
repeat = set.uniq {|e| e.number}
first = repeat[0].number.to_i
second = repeat[1].number.to_i
i = 0
k = 0
set.each do |item |
if(item.number.to_i == first)
i+= 1
end
if(item.number.to_i == second)
k+= 1
end
end

if(i == 2 && k == 3) 
if(second ==1 )
second = 14
end 
return 7 +  second / 100.0
end
if(i == 3 && k == 2)
if(first == 1)
first = 14
end
return 7 + first /100.0
end
return 0

    
end
def three_kind(set)

uniq = set.uniq {|e| e.number}
 if(uniq.size == 3)
 repeat = set - uniq
 head = repeat[0].number.to_i
 repeat.each do |item|
     if head != item.number.to_i
     return 0
     end
   
 end
 if(head == 1 )
  head = 14
 end
 return 6 + head / 100.0

 end
return 0


end

def two_pair(set)
uniq = set.uniq { |e| e.number }
repeat = set - uniq
if(repeat.size > 1)
first = repeat[0].number.to_i
second = repeat[1].number.to_i
else
return 0
end
i = 0
k = 0
set.each do |item|
if(first == item.number.to_i)
i +=1
end
if(second == item.number.to_i)
k += 1
end
end
if(i== 2 && k == 2)
if(first == 1)
first = 14
end
if(second == 1)
second = 14
end
more = high_card(set)
if(more == first || more == second)
more = set[2].number.to_i
end
if(first > second)
return 2 + first / 100.0 + more / 100.0
end

return 2 + second / 100.0 + more /100.0

end

return 0
end


 def pair(set)
  uniq = set.uniq { |e| e.number }
  repeat = set - uniq
 more = high_card(set).to_i
  if(uniq.size == 4)
  
  if(repeat[0].number.to_i == more)
   more = 0
  end
  return 2 + (repeat[0].number.to_i  / 100.0 )+ (more / 100.0)
  end
  return 0
 
 end
 
def high_card(set)
card = set[4].number.to_i
if(set[0].number.to_i == 1)
return 14
end
return card
end







  
 def printcard(cards)
     cards.each do |item|
	print "#{item.showcard}"
     end
     print ""
 end 



 end
