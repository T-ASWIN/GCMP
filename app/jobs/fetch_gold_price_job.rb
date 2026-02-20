require "net/http"
require "json"

class FetchGoldPriceJob < ApplicationJob
  queue_as :default

  def perform
    uri = URI("https://www.goldapi.io/api/XAU/AED")
    request = Net::HTTP::Get.new(uri)
    request["x-access-token"] = ENV["GOLD_API_TOKEN"]
    request["Content-Type"] = "application/json"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    if response.code == "200"
      data = JSON.parse(response.body)

      purity_price = {
        "24k" => data["price_gram_24k"],
        "22k" => data["price_gram_22k"],
        "20k" => data["price_gram_20k"],
        "18k" => data["price_gram_18k"]
      }

      purity_price.each do |purity, price|
        GoldPrice.create!(
          timestamp: Time.at(data["timestamp"]),
          metal:     data["metal"],
          currency:  data["currency"],
          purity:    purity,
          price:     price
        )
      end
      Rails.logger.info "GoldPrice saved successfully."
    else
      Rails.logger.error "API Error: #{response.code} - #{response.body}"
    end
  rescue => errors
    Rails.logger.error "GoldPrice Job Error: #{errors.message}"
    raise errors
  end
end
