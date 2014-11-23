class RemoveUserBelongsTo < ActiveRecord::Migration
  def change
  	change_table :users do |t|
      t.remove :table_id
      t.remove :room_id
      t.remove :game_id
    end
  end
end
