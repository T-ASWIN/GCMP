env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']


set :output, "log/cron.log"

set :environment, "development"

every 1.hour do
  # We use 'runner' to execute Ruby code within the Rails context
  runner "FetchGoldPriceJob.perform_later"
end