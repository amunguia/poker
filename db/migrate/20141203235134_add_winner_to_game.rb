class AddWinnerToGame < ActiveRecord::Migration
  def change
  	change_table :games do |t|
      t.integer :winner_id
  	end
  end
end
