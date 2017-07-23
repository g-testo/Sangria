class StaticPagesController < ApplicationController
  def home
    @yelp_response = Yelp.client.search('New York City', { term: 'Sangria Bars', limit: '6' })
  end
  def about
  end
end
