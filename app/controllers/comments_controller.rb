class CommentsController < ApplicationController
  before_action :find_commentable

    def new
      @comment = Comment.new
    end

    def create
      @comment = @commentable.comments.new comment_params

      if @comment.save
        redirect_to :back, notice: 'Your comment was successfully posted!'
      else
        redirect_to :back, notice: "Your comment wasn't posted!"
      end
    end

    def destroy
      @recipe = Recipe.find(params[:recipe_id])
      @comment = @recipe.comments.find(params[:id])
      @comment.destroy

      redirect_to recipe_path(@recipe)
    end

    private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def find_commentable
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      @commentable = Recipe.find_by_id(params[:recipe_id]) if params[:recipe_id]
    end

end
