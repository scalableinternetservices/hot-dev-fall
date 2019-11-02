class AddIndexToSharers < ActiveRecord::Migration[5.1]
  def change
    add_index :sharers, :email, :unique => true
  end
end
