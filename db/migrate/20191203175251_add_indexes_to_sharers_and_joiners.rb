class AddIndexesToSharersAndJoiners < ActiveRecord::Migration[5.1]
  def change
      add_index :sharers, :status
      add_index :joiners, :status
  end
end
