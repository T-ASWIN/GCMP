class AddPurityAndPriceToGoldPrices < ActiveRecord::Migration[8.1]
  def change
    # Add purity only if it's missing
    unless column_exists?(:gold_prices, :purity)
      add_column :gold_prices, :purity, :string
    end

    # Handle the 'price' column that Postgres complained about
    if column_exists?(:gold_prices, :price)
      # If it exists, ensure it's the correct decimal type
      change_column :gold_prices, :price, :decimal, precision: 10, scale: 4
    else
      # If it doesn't exist, create it
      add_column :gold_prices, :price, :decimal, precision: 10, scale: 4
    end
  end
end
