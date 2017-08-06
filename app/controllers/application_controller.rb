class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def logged_in_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_user_session_path
    end
  end

  def check_logged_in
    user_signed_in? ? '' : (redirect_to new_user_session_path, alert: "Please sign in to do that.")
  end
end
