class CreateContracts < ActiveRecord::Migration[5.1]
  def change
    create_table :contracts do |t|
      t.references :sharer, foreign_key: true
      t.references :joiners, foreign_key: true
      t.string :username
      t.string :password

      t.timestamps
    end
    add_index :contracts, [:sharer_id, :created_at]
  end
end
