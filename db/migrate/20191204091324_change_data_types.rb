class ChangeDataTypes < ActiveRecord::Migration[5.1]
  def change
    change_column :sharers, :size, :integer, :limit => 1
    change_column :sharers, :user_id, :integer, :limit => 2
    change_column :sharers, :plan_cost, :decimal, :precision => 4, :scale => 3
    change_column :sharers, :service, :string, :limit => 8
    change_column :sharers, :account_id, :string, :limit => 16
    change_column :sharers, :account_password, :string, :limit => 16
    change_column :sharers, :status, :string, :limit => 8

    change_column :messages, :content, :string
    change_column :messages, :contract_id, :integer, :limit => 2
    change_column :messages, :sender_email, :string, :limit => 16

    change_column :joiners, :user_id, :integer, :limit => 2
    change_column :joiners, :service, :string, :limit => 8
    change_column :joiners, :status, :string, :limit => 8

    change_column :contracts, :sharer_id, :integer, :limit => 2
    change_column :contracts, :sharer_uid, :integer, :limit => 2
    change_column :contracts, :joiner_uid, :integer, :limit => 2
    change_column :contracts, :account_id, :string, :limit => 16
    change_column :contracts, :account_password, :string, :limit => 16
    change_column :contracts, :price, :decimal, :precision => 4, :scale => 3

  end
end
