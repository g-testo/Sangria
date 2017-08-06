class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def new
    @recipe.comments.build
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.create(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.recipe, notice: 'Comment was successfully created.' }
        format.json { render :index, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to recipe_url(@comment.recipe), notice: 'Recipe was successfully removed.' }
      format.json { head :no_content }
    end
  end

  def edit
    @comment = @recipe.comments.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @comment = @recipe.comments.find(params[:id])
    respond_to do |format|
      if @comment.update(recipe_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :index, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def set_comment
     @comment = Comment.find(params[:id])
  end
  def comment_params
    params.require(:comment).permit(:commenter, :body, :user_id)
  end
end
