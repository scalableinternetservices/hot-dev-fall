class ConvertSharersToShareQuery < ActiveRecord::Migration[5.1]
  def change
    # remove_column :sharers, :created_at
    # remove_column :sharers, :updated_at
    remove_column :sharers, :firstname
    remove_column :sharers, :lastname
    remove_column :sharers, :max_member_count
    remove_column :sharers, :plantype
    remove_column :sharers, :planfull
    remove_column :sharers, :members
    remove_column :sharers, :current_member_count
    remove_column :sharers, :email
    
    add_reference :sharers, :user, index: true
    add_column :sharers, :service, :string
    add_column :sharers, :size, :integer
    add_column :sharers, :account_id, :string
    add_column :sharers, :account_password, :string
    add_column :sharers, :status, :string

  end
end
