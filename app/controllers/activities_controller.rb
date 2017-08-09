class ActivitiesController < ApplicationController
  def index
      @activities = PublicActivity::Activity.order("created_at desc")
      @users = User.where(is_private = false).order(created_at: :desc).all
  end
end
