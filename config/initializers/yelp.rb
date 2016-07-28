require 'yelp'

Yelp.client.configure do |config|
  config.consumer_key = ENV["YOUR_CONSUMER_KEY"]
  config.consumer_secret = ENV["YOUR_CONSUMER_SECRET"]
  config.token = ENV["YOUR_TOKEN"]
  config.token_secret = ENV["YOUR_TOKEN_SECRET"]
end