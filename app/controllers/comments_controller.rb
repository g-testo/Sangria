class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_filter :check_logged_in, only: [:edit, :update, :destroy]
  respond_to :html, :js
  def new
    @recipe.comments.build
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.create(comment_params)
    respond_to do |format|
      if @comment.save
        @comment.create_activity :create, owner: current_user
        format.html { redirect_to @comment.recipe, notice: 'Comment was successfully created.' }
        format.json { render :index, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.create_activity :destroy, owner: current_user
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
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
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
