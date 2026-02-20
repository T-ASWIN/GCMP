class GoldPricesController < ApplicationController
  before_action :authenticate_user!

  def index
     @latest_price = GoldPrice.latest_set
  end

 
end
