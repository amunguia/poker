class Deck

  def self.init
    @@card_string = []
    @@card_hash = {}

    ha = Card.new 14, "H"
    @@card_string<< ha.to_s
    @@card_hash[ha.to_s] = ha

    da = Card.new 14, "D"
    @@card_string<< da.to_s
    @@card_hash[da.to_s] = da

    sa = Card.new 14, "S"
    @@card_string<< sa.to_s
    @@card_hash[sa.to_s] = sa

    ca = Card.new 14, "C"
    @@card_string<< ca.to_s
    @@card_hash[ca.to_s] = ca


    h2 = Card.new 2, "H"
    @@card_string<< h2.to_s
    @@card_hash[h2.to_s] = h2

    d2 = Card.new 2, "D"
    @@card_string<< d2.to_s
    @@card_hash[d2.to_s] = d2

    s2 = Card.new 2, "S"
    @@card_string<< s2.to_s
    @@card_hash[s2.to_s] = s2

    c2 = Card.new 2, "C"
    @@card_string<< c2.to_s
    @@card_hash[c2.to_s] = c2

    
    h3 = Card.new 3, "H"
    @@card_string<< h3.to_s
    @@card_hash[h3.to_s] = h3

    d3 = Card.new 3, "D"
    @@card_string<< d3.to_s
    @@card_hash[d3.to_s] = d3

    s3 = Card.new 3, "S"
    @@card_string<< s3.to_s
    @@card_hash[s3.to_s] = s3

    c3 = Card.new 3, "C"
    @@card_string<< c3.to_s
    @@card_hash[c3.to_s] = c3


    h4 = Card.new 4, "H"
    @@card_string<< h4.to_s
    @@card_hash[h4.to_s] = h4

    d4 = Card.new 4, "D"
    @@card_string<< d4.to_s
    @@card_hash[d4.to_s] = d4

    s4 = Card.new 4, "S"
    @@card_string<< s4.to_s
    @@card_hash[s4.to_s] = s4

    c4 = Card.new 4, "C"
    @@card_string<< c4.to_s
    @@card_hash[c4.to_s] = c4


    h5 = Card.new 5, "H"
    @@card_string<< h5.to_s
    @@card_hash[h5.to_s] = h5

    d5 = Card.new 5, "D"
    @@card_string<< d5.to_s
    @@card_hash[d5.to_s] = d5

    s5 = Card.new 5, "S"
    @@card_string<< s5.to_s
    @@card_hash[s5.to_s] = s5

    c5 = Card.new 5, "C"
    @@card_string<< c5.to_s
    @@card_hash[c5.to_s] = c5


    h6 = Card.new 6, "H"
    @@card_string<< h6.to_s
    @@card_hash[h6.to_s] = h6

    d6 = Card.new 6, "D"
    @@card_string<< d6.to_s
    @@card_hash[d6.to_s] = d6

    s6 = Card.new 6, "S"
    @@card_string<< s6.to_s
    @@card_hash[s6.to_s] = s6
 
    c6 = Card.new 6, "C"
    @@card_string<< c6.to_s
    @@card_hash[c6.to_s] = c6


    h7 = Card.new 7, "H"
    @@card_string<< h7.to_s
    @@card_hash[h7.to_s] = h7

    d7 = Card.new 7, "D"
    @@card_string<< d7.to_s
    @@card_hash[d7.to_s] = d7

    s7 = Card.new 7, "S"
    @@card_string<< s7.to_s
    @@card_hash[s7.to_s] = s7

    c7 = Card.new 7, "C"
    @@card_string<< c7.to_s
    @@card_hash[c7.to_s] = c7

    
    h8 = Card.new 8, "H"
    @@card_string<< h8.to_s
    @@card_hash[h8.to_s] = h8

    d8 = Card.new 8, "D"
    @@card_string<< d8.to_s
    @@card_hash[d8.to_s] = d8

    s8 = Card.new 8, "S"
    @@card_string<< s8.to_s
    @@card_hash[s8.to_s] = s8

    c8 = Card.new 8, "C"
    @@card_string<< c8.to_s
    @@card_hash[c8.to_s] = c8


    h9 = Card.new 9, "H"
    @@card_string<< h9.to_s
    @@card_hash[h9.to_s] = h9

    d9 = Card.new 9, "D"
    @@card_string<< d9.to_s
    @@card_hash[d9.to_s] = d9

    s9 = Card.new 9, "S"
    @@card_string<< s9.to_s
    @@card_hash[s9.to_s] = s9

    c9 = Card.new 9, "C"
    @@card_string<< c9.to_s
    @@card_hash[c9.to_s] = c9

  
    h10 = Card.new 10, "H"
    @@card_string<< h10.to_s
    @@card_hash[h10.to_s] = h10

    d10 = Card.new 10, "C"
    @@card_string<< d10.to_s
    @@card_hash[d10.to_s] = d10

    s10 = Card.new 10, "S"
    @@card_string<< s10.to_s
    @@card_hash[s10.to_s] = s10

    c10 = Card.new 10, "C"
    @@card_string<< c10.to_s
    @@card_hash[c10.to_s] = c10
    

    h11 = Card.new 11, "H"
    @@card_string<< h11.to_s
    @@card_hash[h11.to_s] = h11

    d11 = Card.new 11, "D"
    @@card_string<< d11.to_s
    @@card_hash[d11.to_s] = d11

    s11 = Card.new 11, "S"
    @@card_string<< s11.to_s
    @@card_hash[s11.to_s] = s11
 
    c11 =Card.new 11, "C"
    @@card_string<< c11.to_s
    @@card_hash[c11.to_s] = c11

 
    h12 = Card.new 12, "H"
    @@card_string<< h12.to_s
    @@card_hash[h12.to_s] = h12

    d12 = Card.new 12, "D"
    @@card_string<< d12.to_s
    @@card_hash[d12.to_s] = d12

    s12 = Card.new 12, "S"
    @@card_string<< s12.to_s
    @@card_hash[s12.to_s] = s12

    c12 = Card.new 12, "C"
    @@card_string<< c12.to_s
    @@card_hash[c12.to_s] = c12


    h13 = Card.new 13, "H"
    @@card_string<< h13.to_s
    @@card_hash[h13.to_s] = h13

    d13 = Card.new 13, "D"
    @@card_string<< d13.to_s
    @@card_hash[d13.to_s] = d13

    s13 = Card.new 13, "S"
    @@card_string<< s13.to_s
    @@card_hash[s13.to_s] = s13

    c13 = Card.new 13, "C"
    @@card_string<< c13.to_s
    @@card_hash[c13.to_s] = c13
  end

  def self.new_deck
    @@card_string.shuffle!.slice(0,13)
  end

  def self.card_for_string(string)
    @@card_hash[string]
  end

end

Deck.init










