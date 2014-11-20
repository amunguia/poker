# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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
  end.save

  Table.new do |t|
    t.number = i
    t.room = medium_room
  end.save

   Table.new do |t|
     t.number = i
     t.room = high_roller_room
   end.save
end
