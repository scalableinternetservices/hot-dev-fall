class CreateJoiners < ActiveRecord::Migration[5.1]
  def change
    create_table :joiners do |t|
      t.string :email,      null: false, default: ""
      t.string :firstname,  null: false, default: ""
      t.string :lastname,   null: false, default: ""
      t.boolean :matched
      t.string :host_email, null: false, default: ""

      t.timestamps
    end
  end
end
