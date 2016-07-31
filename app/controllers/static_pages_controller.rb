class StaticPagesController < ApplicationController
  def home
    @twitter_response = ApplicationController::CLIENT.search("#SangriaNYC -rt", lang: "en").take(5)
    
    flikr_response = flickr.photos.search(:tags => "sangria", :per_page => 6)
    
    @flickr_photos = []
    
    flikr_response.each do |image| 
      id = flickr.photos.getInfo(:photo_id => image.id)
      photo = FlickRaw.url_t(id) 
      @flickr_photos.push(photo)
    end 
    
    @yelp_response = Yelp.client.search('New York City', { term: 'Sangria Bars', limit: '10' })
    
    
  end
  def about
  end
  def contact
  end
end