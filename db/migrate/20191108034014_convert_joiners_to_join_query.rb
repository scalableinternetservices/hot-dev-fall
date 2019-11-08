class ConvertJoinersToJoinQuery < ActiveRecord::Migration[5.1]
  def change
    remove_column :joiners, :firstname
    remove_column :joiners, :lastname
    # remove_column :joiners, :created_at
    # remove_column :joiners, :updated_at
    remove_column :joiners, :email
    remove_column :joiners, :matched
    remove_column :joiners, :host_email
    
    add_reference :joiners, :user, index: true

    add_column :joiners, :service, :string
    add_column :joiners, :status, :string
  end
end
