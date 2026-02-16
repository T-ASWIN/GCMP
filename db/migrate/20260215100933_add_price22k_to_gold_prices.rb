class AddPrice22kToGoldPrices < ActiveRecord::Migration[8.1]
  def change
    add_column :gold_prices, :price_22k, :float
  end
end
