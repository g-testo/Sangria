class RatingsController < ApplicationController
  before_filter :check_logged_in, only: [:update]

  def update
    @rating = Rating.find(params[:id])
    @recipe = @rating.recipe
    if @rating.update_attributes(score: params[:score])
      respond_to do |format|
        format.js
      end
    end
  end
end
