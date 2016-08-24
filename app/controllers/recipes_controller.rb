class RecipesController < ApplicationController
  def index
  
  if params[:flavor]
    @recipes = Recipe.where(:flavor => params[:flavor])
  else
    @recipes = Recipe.all
    @recipes = Recipe.paginate(page: params[:page], :per_page => 6)
  end

  
  end

  def new
    @recipe = current_user.recipes.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
        redirect_to @recipe, alert: "Recipe created successfully."
    else
        redirect_to new_recipe_path, alert: "Error creating recipe."
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
  
  def edit
    @recipe = Recipe.find(params[:id])
  end
  
  def update
    @recipe = Recipe.find(params[:id])
    
    if @recipe.update(recipe_params)
        redirect_to @recipe, alert: "Recipe updated successfully."
    else
        redirect_to edit_recipe_path(@recipe), alert: "Error updating recipe."
    end
  end
  
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    
    redirect_to recipes_path
  end
  
  private
    def recipe_params
      params.require(:recipe).permit(:name, :instructions, :author, :servings, :recipe_image, :user_id, :flavor)
    end
end