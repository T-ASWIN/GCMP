class ChangeTimestampToDatetimeInGoldPrices < ActiveRecord::Migration[8.1]
  def change
    change_column :gold_prices, :timestamp, 'timestamp WITH TIME ZONE USING TO_TIMESTAMP(timestamp)'
  end
end
