class ChangeGameUserReferences < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.remove :p1_bal, :p2_bal, :p3_bal, :p4_bal
      t.remove :p1_max, :p2_max, :p3_max, :p4_max
      t.integer :p1
      t.integer :p2
      t.integer :p3
      t.integer :p4
    end
  end
end
