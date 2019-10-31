class AddUsertypeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :usertype, :string, null: false, default: ""
  end
end
