class AddFieldsToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :content, :text
    add_reference :messages, :contract, foreign_key: true
  end
  add_index :messages, [:created_at]
end
