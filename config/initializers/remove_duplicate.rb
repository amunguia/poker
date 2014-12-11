high_roller_room = Room.find_by_name("High Rollers Room")
high_roller_tables = Table.where(room_id: high_roller_room.id)
array = []
high_roller_tables.each do |t|
  if array.include? t.number
    t.destroy
  else
    array<< t.number
  end
end