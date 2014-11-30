class AddMessageToGame < ActiveRecord::Migration
  def change
  	change_table :games do |t|
      t.string :message
  	end
  end
end
