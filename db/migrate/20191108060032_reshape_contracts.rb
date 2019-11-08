class ReshapeContracts < ActiveRecord::Migration[5.1]
  def change
    remove_column :contracts, :sharer_id
    remove_column :contracts, :joiners_id
    remove_column :contracts, :username
    remove_column :contracts, :password
    # remove_column :contracts, :created_at
    # remove_column :contracts, :updated_at
    
    add_reference :contracts, :sharer
    
    add_column :contracts, :sharer_uid, :int
    add_column :contracts, :joiner_uid, :int
    add_column :contracts, :account_id, :int
    add_column :contracts, :account_password, :int

    add_index :contracts, :sharer_uid
    add_index :contracts, :joiner_uid

  end
end
