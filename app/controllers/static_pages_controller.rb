class StaticPagesController < ApplicationController
  def home
    # @twitter_response = ApplicationController::CLIENT.search("#SangriaNYC -rt", lang: "en").take(5)
    @yelp_response = Yelp.client.search('New York City', { term: 'Sangria Bars', limit: '5' })
  end
  def about
  end
  def contact
  end
end