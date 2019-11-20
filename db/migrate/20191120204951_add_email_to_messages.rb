class AddEmailToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :email, :string
  end
end
