class AddStreamToGames < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.string :stream
    end
  end
end
