class AddOrderToGame < ActiveRecord::Migration
  def change
  	change_table :games do |t|
      t.string :order
  	end
  end
end
