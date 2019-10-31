class AddDetailToJoiners < ActiveRecord::Migration[5.1]
  def change
    add_column :joiners, :email, :string, null: false, default: ""
    add_column :joiners, :matched, :string, null: false, default: ""
    add_column :joiners, :host_email, :string, null: false, default: ""
    add_index :joiners, :email, :unique => true
  end
end
