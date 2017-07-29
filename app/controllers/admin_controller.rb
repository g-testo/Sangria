class AdminController < ActionController::Base

  def admin_page
    @recipes = Recipe.all
    @users = User.all
  end
end
