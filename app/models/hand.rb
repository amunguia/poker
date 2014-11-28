ddclass Hand
  
  attr_accessor :numbers
  
  def initialize(cards)
    @cards = cards
    @numbers = get_number_array 
    @numbers.sort!
    get_frequencies
  end
  
  def get_number_array
    array = Array.new
    @cards.each do  |c|
      array<< c.number
    end
    array
  end
  
  def get_score
    if (score = straight_flush)
      score
    elsif (score = four_kind)
      score
    elsif (score = full_house) 
      score
    elsif (score = flush)
      score
    elsif (score = straight)
      score
    elsif (score = three_kind)
      score
    elsif (score = two_pair)
      score
    elsif (score = pair)
      score 
    else 
      high_card
    end
  end
  
  def straight_flush
    if straight && flush
      
    end
    return 0
  end
  
  def four_kind
    @frequency.each do |k, v|
      if v == 4
        return 8 + k/100.0
      end
    end
    return 0
  end
  
  def full_house
    if three_kind && pair
      return three_kind + 3 #Tricky whate if pppl have same suit.
    end
  end
  
  def flush
    suit_freq = {}
    @cards.each do |c|
      if suit_freq[c.get_dec]
        suit_freq[c.get_dec] += 1
      else  
        suit_freq[c.get_dec] = 1
      end
    end
    
    suit_freq.each do |k, v|
      if v >= 5
        return 6 + k/100.0
      end
    end
    return 0
  end
  
  def straight
    last = -5
    running = 1
    highest = -1
    if @numbers[6] == 14
      last = 1
    end
    
    (0..6).each do |i|
      if @numbers[i] - 1 == last
        puts @numbers[i]
        running += 1
        if running >= 5
          highest = @numbers[i]
        end
      else
        running = 1
      end
      last = @numbers[i]
    end
    
    if highest > 0
      return 5 + highest/100.0
    else
      return 0
    end
  end
    
  def three_kind
    score = 0
    @frequency.each do |k, v|
      if v == 3
        score = (4 + k/100.0 > score)? 4 + k/100.0: score
      end
    end
    return score
  end
  
  def two_pair
    pairs = 0
    lastk = 0
    score = 0
    @frequency.each do |k, v|
      if v == 2 && pairs > 1
        k = (lastk > k)? lastk : k
        score = (3 + k/100.0 > score)? 3 + k/100.0 : score
      elsif v == 2
        pairs += 1
        lastk = k
      end
    end
    return score
  end
  
  def pair
    score = 0
    @frequency.each do |k, v|
      if v == 2
        score = (2 + k/100.0 > score)? 2 + k/100.0: score
      end
    end
    return score
  end
  
  def high_card  #1
    1+ @numbers[6]/100.0
  end
  
  def get_frequencies
    @frequency = {}
    @numbers.each do |i|
      if @frequency[i]
        @frequency[i] += 1
      else
        @frequency[i] = 1
      end
    end
  end
  
  def self.test_hand
    cards = []
    cards<< Card.new(6,"H")
    cards<< Card.new(14,"H")
    cards<< Card.new(9,"H")
    cards<< Card.new(12,"H")
    cards<< Card.new(11,"H")
    cards<< Card.new(13,"H")
    cards<< Card.new(10,"H")
    
    Hand.new cards
  end
  
end