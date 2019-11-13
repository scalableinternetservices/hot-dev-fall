class PriceModel < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :price, :float
    add_column :sharers, :plan_cost, :float
  end
end
