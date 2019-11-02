class AddFirstnameToJoiners < ActiveRecord::Migration[5.1]
  def change
    add_column :joiners, :firstname, :string, null: false, default: ""
    add_column :joiners, :lastname, :string, null: false, default: ""
  end
end
