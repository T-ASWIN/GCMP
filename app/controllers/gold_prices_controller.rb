class GoldPricesController < ApplicationController
  before_action :authenticate_user!

  def index
     @latest_price = GoldPrice.latest_set
  end

  def update_goldrate
    FetchGoldPriceJob.perform_later
    redirect_to gold_prices_path, notice: "Fetch request sented"
  end
end