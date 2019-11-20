class RenameEmailToSenderEmail < ActiveRecord::Migration[5.1]
  def change
      rename_column :messages, :email, :sender_email
  end
end
