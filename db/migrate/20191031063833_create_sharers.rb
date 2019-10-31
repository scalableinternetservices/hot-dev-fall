class CreateSharers < ActiveRecord::Migration[5.1]
  def change
    create_table :sharers do |t|

      t.timestamps
    end
  end
end
