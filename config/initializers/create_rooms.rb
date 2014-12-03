#This initializer will create the rooms and tables that form the basic website.

if !Room.find_by_name("Basic Room")

  basic_room = Room.new do |r|
    r.name = "Basic Room"
    r.minimum_bet = 5
  end
  basic_room.save

  medium_room = Room.new do |r|#
    r.name = "Medium Room"
    r.minimum_bet = 20
  end
  medium_room.save

  high_roller_room = Room.new do |r|
    r.name = "High Rollers Room"
    r.minimum_bet = 50
  end
  high_roller_room.save


  (1..10).each do |i|
    Table.new do |t|
      t.number = i
      t.room = basic_room  
      t.min_bet = basic_room.minimum_bet
    end.save

    Table.new do |t|
      t.number = i
      t.room = medium_room
      t.min_bet = medium_room.minimum_bet
    end.save

   Table.new do |t|
      t.number = i
      t.room = high_roller_room
      t.min_bet = high_roller_room.minimum_bet
   end.save

   Table.new do |t|
      t.number = i
      t.room = high_roller_room
    end.save
  end
end
