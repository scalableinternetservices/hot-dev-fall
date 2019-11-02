class RemoveNameFromJoiners < ActiveRecord::Migration[5.1]
  def change
    remove_column :joiners, :name, :string
  end
end
