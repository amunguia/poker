class AddMinBetToGames < ActiveRecord::Migration
  def change
  	change_table :games do |t|
      t.boolean :new_round
      t.integer :min_bet
  	end
  end
end
