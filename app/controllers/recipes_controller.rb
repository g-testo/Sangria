class RecipesController < ApplicationController
  before_filter :check_logged_in, only: [:create, :edit, :update, :destroy]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  respond_to :html, :js
  def index
    if params[:flavor]
      recipeFlavor = params[:flavor]
      if recipeFlavor != "exotic"
        @title = "#{recipeFlavor.capitalize} Wine Recipes"
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
        with_flavor_wine: {'Red': 'red', 'White': 'white', 'Exotic': 'exotic'}
      },
      :persistence_id => false,
    ) or return
    @recipes = @filterrific.find.page(params[:page])
    @recipes = @recipes.paginate(page: params[:page], :per_page => 6)
    respond_to do |format|
      format.html
      format.js
    end
    rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def new
    @recipe = current_user.recipes.new
    @recipe.ingredients.build
    @counter = 0
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    @recipe.author = current_user.user_name
    respond_to do |format|
      if @recipe.save
        @recipe.create_activity :create, owner: current_user
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :index, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    # Recipe.find(params[:id])
    @ingredients = Ingredient.where( :recipe_id => @recipe.id )
    if current_user
      @rating = Rating.where(recipe_id: @recipe.id, user_id: current_user.id).first
      unless @rating
        @rating = Rating.create(recipe_id: @recipe.id, user_id: current_user.id, score: 0)
      end
    end
  end

  def edit
    @counter = 0
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        @recipe.create_activity :update, owner: current_user
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :index, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe.create_activity :destroy, owner: current_user
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully removed.' }
      format.json { head :no_content }
    end
  end

  def visibility_auth(curr_user, comment_id)
    !curr_user.blank? && (curr_user.id == comment_id)
  end
  helper_method :visibility_auth

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :instructions, :author, :servings, :recipe_image, :user_id, :flavor, :avg_rating, ingredients_attributes: [:name, :quantity, :category, :_destroy, :id])
  end
end
