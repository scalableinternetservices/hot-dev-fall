class CreateJoiners < ActiveRecord::Migration[5.1]
  def change
    create_table :joiners do |t|
      t.string :email
      t.string :name
      t.boolean :matched
      t.string :host_email

      t.timestamps
    end
  end
end
