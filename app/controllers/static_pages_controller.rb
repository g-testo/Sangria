class StaticPagesController < ApplicationController
  def home
    if !@yelp_response.blank?
      @yelp_response = Yelp.client.search('New York City', { term: 'Sangria Bars', limit: '6' })
    end
    if Recipe.ids.length != 0
      @randomRecipe = Recipe.find(Recipe.ids.sample)
    end
  end
  def about
  end
end
