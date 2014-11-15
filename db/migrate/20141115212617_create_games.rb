class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :player_order
      t.integer :current_bal
      t.integer :p1_bal
      t.integer :p2_bal
      t.integer :p3_bal
      t.integer :p4_bal
      t.integer :p1_max
      t.integer :p2_max
      t.integer :p3_max
      t.integer :p4_max
      t.string :p1_cards
      t.string :p2_cards
      t.string :p3_cards
      t.string :p4_cards
      t.string :card1
      t.string :card2
      t.string :card3
      t.string :card4
      t.string :card5

      t.timestamps
      t.belongs_to :table

    end 

    change_table :users do |t|
      t.belongs_to :game
    end

  end
end
