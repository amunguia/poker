class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :minimum_bet

      t.timestamps
    end

    change_table :users do |t|
      t.belongs_to :room
    end
  end
end
