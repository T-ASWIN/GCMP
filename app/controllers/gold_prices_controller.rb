class GoldPricesController < ApplicationController
  before_action :authenticate_user!

  def index
     @latest_price = GoldPrice.latest
  end

  def refresh
    FetchGoldPriceJob.perform_later
    redirect_to gold_prices_path, notice: "Fetch request sented"
  end
end