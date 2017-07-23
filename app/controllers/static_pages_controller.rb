class StaticPagesController < ApplicationController
  def home
    @yelp_response = Yelp.client.search('New York City', { term: 'Sangria Bars', limit: '6' })
    if Recipe.ids.length != 0
      @randomRecipe = Recipe.find(Recipe.ids.sample)
    end
  end
  def about
  end
end
