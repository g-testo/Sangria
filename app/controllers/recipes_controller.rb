class RecipesController < ApplicationController
  helper_method :sort_column, :sort_direction
  def index
    if params[:flavor]
      recipeFlavor = params[:flavor]
      if recipeFlavor != "Other"
        @title = "#{recipeFlavor} Recipes"
      else
        @title = "Unique Recipes"
      end
      @recipes = Recipe.where(:flavor => params[:flavor]).order(sort_column + " " + sort_direction)
    else
      @title = "All Recipes"
      if sort_column != "rating"
        @recipes = Recipe.order(sort_column + " " + sort_direction)
      else
        @recipes = Recipe.joins(:ratings)
          .select("recipes.*, avg(ratings.score) as average_rating, count(ratings.id) as number_of_ratings")
          .order("average_rating " + sort_direction + ", number_of_ratings " + sort_direction)
        end
        # @recipes = @recipes.paginate(page: params[:page], :per_page => 6)
      end
  end

  def new
    @recipe = current_user.recipes.new
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
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    current_user.inspect
    @recipe.author = current_user.user_name
    if @recipe.save
        redirect_to @recipe, notice: "Recipe created successfully."
    else
        redirect_to new_recipe_path, alert: "Error creating recipe."
    end
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
    params.require(:recipe).permit(:name, :instructions, :author, :servings, :recipe_image, :user_id, :flavor, :ingredients)
  end

  def sort_column
    Recipe.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
