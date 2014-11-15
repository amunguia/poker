class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.integer :number
      t.belongs_to :room
      t.timestamps
    end

    change_table :users do |t|
      t.belongs_to :table
    end
  end
end
