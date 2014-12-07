class AddMinBetToTableAndRoom < ActiveRecord::Migration
  def change
  	change_table :tables do |t|
      t.integer :min_bet
  	end
  end
end
