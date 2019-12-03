class AddServiceToContract < ActiveRecord::Migration[5.1]
  def change
      add_column :contracts, :service, :string
  end
end
