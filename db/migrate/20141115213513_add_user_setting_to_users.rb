class AddUserSettingToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :user_level
    end
  end
end
