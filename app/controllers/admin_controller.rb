class AdminController < ActionController::Base
  before_filter :authenticate

  def admin_page
    @recipes = Recipe.all
    @users = User.all
  end
  def authenticate
    redirect_to(root_path) unless current_user.admin?
  end
end
