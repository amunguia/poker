class AddPlayersLeftAndRoundCountToGames < ActiveRecord::Migration
  def change
  	change_table :games do |t|
      t.integer :round_count
      t.integer :players_left
  	end
  end
end
