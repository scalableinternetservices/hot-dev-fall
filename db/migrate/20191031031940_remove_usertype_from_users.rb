class RemoveUsertypeFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :usertype, :string
  end
end
