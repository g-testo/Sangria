class IngredientsController < ApplicationController
  before_filter :check_logged_in, only: [:create, :edit, :update, :destroy]
  def update
    @ingredient = Ingredient.find(params[:id])
    respond_to do |format|
      if @ingredient.update(ingredient_params)
        format.html { redirect_to @ingredient, notice: 'Recipe was successfully updated.' }
        format.json { render :index, status: :ok, location: @ingredient }
      else
        format.html { render :edit }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:quantity, :category, :name, :measurement)
  end
end
