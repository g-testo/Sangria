class RatingsController < ApplicationController

  def update
    @rating = Rating.find(params[:id])
    @recipe = @rating.recipe
    if @rating.update_attributes(score: params[:score])
      avg = @recipe.average_rating
      Recipe.update(@recipe.id, :avg_rating => avg)
      respond_to do |format|
        format.js
      end
    end
  end
end
