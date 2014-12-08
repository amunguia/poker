class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.string :message

      t.belongs_to :user
      t.belongs_to :table
      t.timestamps
    end
  end
end
