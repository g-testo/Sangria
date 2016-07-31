class StaticPagesController < ApplicationController
  def home
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_YOUR_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_YOUR_CONSUMER_SECRET"]
      config.access_token        = ENV["YOUR_ACCESS_TOKEN"]
      config.access_token_secret = ENV["YOUR_ACCESS_SECRET"]
    end
    
    flikr_response = flickr.photos.search(:tags => "sangria", :per_page => 6)
    
    @flikr_photos = []
    
    flikr_response.each do |image| 
      id = flickr.photos.getInfo(:photo_id => image.id)
      photo = FlickRaw.url_t(id) 
      @flikr_photos.push(photo)
    end 
    
    @yelp_response = Yelp.client.search('New York City', { term: 'Sangria Bars', limit: '10' })
    
    
  end
  def about
  end
  def contact
  end
end