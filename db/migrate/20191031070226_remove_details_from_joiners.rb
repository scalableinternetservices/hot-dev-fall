class RemoveDetailsFromJoiners < ActiveRecord::Migration[5.1]
  def change
    remove_column :joiners, :email, :string
    remove_column :joiners, :matched, :string
    remove_column :joiners, :host_email, :string
  end
end
