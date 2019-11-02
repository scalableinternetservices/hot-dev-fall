class AddDetailsToSharers < ActiveRecord::Migration[5.1]
  def change
    add_column :sharers, :firstname, :string, null: false, default: ""
    add_column :sharers, :lastname, :string, null: false, default: ""
    add_column :sharers, :email, :string, null: false, default: ""
    add_column :sharers, :plantype, :string, null: false, default: ""
    add_column :sharers, :max_member_count, :integer, null: false, default: 0
    add_column :sharers, :current_member_count, :integer, null: false, default: 0
    add_column :sharers, :planfull, :boolean, null: false, default: ""
    add_column :sharers, :members, :string, null: false, default: ""
  end
end
