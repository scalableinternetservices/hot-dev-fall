class CreateContracts < ActiveRecord::Migration[5.1]
  def change
    create_table :contracts do |t|
      t.integer :sharer
      t.integer :joiners
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
