class StaticPagesController < ApplicationController
  def home
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_YOUR_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_YOUR_CONSUMER_SECRET"]
      config.access_token        = ENV["YOUR_ACCESS_TOKEN"]
      config.access_token_secret = ENV["YOUR_ACCESS_SECRET"]
    end
    
    
    @yelp_response = Yelp.client.search('New York City', { term: 'Sangria Bars', limit: '10' })
    
    
  end
  def about
  end
  def contact
  end
end