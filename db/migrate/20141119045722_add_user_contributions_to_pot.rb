class AddUserContributionsToPot < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.integer :p1_contrib
      t.integer :p2_contrib
      t.integer :p3_contrib
      t.integer :p4_contrib
    end
  end
end
