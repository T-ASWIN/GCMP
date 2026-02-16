class CreateGoldPrices < ActiveRecord::Migration[8.1]
  def change
    create_table :gold_prices do |t|
      t.integer :timestamp
      t.string :metal
      t.string :currency
      t.float :price
      t.float :price_gram_22k

      t.timestamps
    end
  end
end
