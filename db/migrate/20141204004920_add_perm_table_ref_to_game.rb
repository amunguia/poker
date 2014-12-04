class AddPermTableRefToGame < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.integer :perm_table
    end
  end
end
