require 'net/http'
require 'json'

class FetchGoldPriceJob < ApplicationJob
  queue_as :default

  def perform
    goldApiUri = URI('https://www.goldapi.io/api/XAU/USD')
    request = Net::HTTP::Get.new(goldApiUri)
    
    # 2. Pull the token from your new credentials
    token = Rails.application.credentials.dig(:gold_api, :access_token)
    request["x-access-token"] = token
    request["Content-Type"] = "application/json"

    # 3. Make the call
    response = Net::HTTP.start(goldApiUri.hostname, goldApiUri.port, use_ssl: true) do |http|
      http.request(request)
    end

    # 4. Handle the data
    if response.code == "200"
      data = JSON.parse(response.body)
      
      # Saving to the database so your controller can find it later
      GoldPrice.create!(
        timestamp: data['timestamp'],
        metal:     data['metal'],
        currency:  data['currency'],
        price_22k: data['price_gram_22k'] # Mapping the API's 22K to our DB
      )
      
      Rails.logger.info "SUCCESS! Saved 22K Gold Price: #{data['price_gram_22K']}"
    else
      Rails.logger.error "ERROR: #{response.code} - #{response.body}"
      raise "API Fetch Failed" # Raising an error lets GoodJob know to retry
    end
    rescue StandardError => e
    Rails.logger.error "Job Failed: #{e.message}"
  end
end