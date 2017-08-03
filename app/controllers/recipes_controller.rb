class RecipesController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    if params[:flavor]
      recipeFlavor = params[:flavor]
      if recipeFlavor != "Exotic"
        @title = "#{recipeFlavor} Recipes"
      else
        @title = "Exotic Recipes"
      end
      @recipes = Recipe.where(:flavor => params[:flavor])
    else
      @title = "All Recipes"
      @recipes = Recipe.all
    end
    @filterrific = initialize_filterrific(
      @recipes,
      params[:filterrific],
      :select_options => {
        sorted_by: @recipes.options_for_sorted_by,
        with_flavor_wine: ['Red Wine', 'White Wine', 'Exotic']
      },
      :persistence_id => false,
    ) or return
    @recipes = @filterrific.find.page(params[:page])
    @recipes = @recipes.paginate(page: params[:page], :per_page => 6)
  end

  def new
    @recipe = current_user.recipes.new
    @recipe.ingredients.build
    @counter = 0
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    @recipe.author = current_user.user_name
    if @recipe.save
        redirect_to @recipe, notice: "Recipe created successfully."
    else
        redirect_to new_recipe_path, alert: "Error creating recipe."
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    if current_user
      @rating = Rating.where(recipe_id: @recipe.id, user_id: current_user.id).first
      unless @rating
        @rating = Rating.create(recipe_id: @recipe.id, user_id: current_user.id, score: 0)
      end
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @counter = 0
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
        redirect_to @recipe, notice: "Recipe updated successfully."
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
    params.require(:recipe).permit(:name, :instructions, :author, :servings, :recipe_image, :user_id, :flavor, :avg_rating, ingredients_attributes: [:name, :quantity, :category, :_destroy, :id])
  end
end
