class AdminController < ActionController::Base
  before_filter :admin_authenticate

  def admin_page
    @recipes = Recipe.all
    @users = User.all
  end
  def admin_authenticate
    redirect_to(root_path) unless current_user.admin?
  end
end
