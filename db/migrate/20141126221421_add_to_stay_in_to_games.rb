class AddToStayInToGames < ActiveRecord::Migration
  def change
  	change_table :games do |t|
      t.integer :each_contrib
  	end
  end
end
