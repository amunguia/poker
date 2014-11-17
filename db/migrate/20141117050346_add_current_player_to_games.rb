class AddCurrentPlayerToGames < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.string :current_player
    end
  end
end
