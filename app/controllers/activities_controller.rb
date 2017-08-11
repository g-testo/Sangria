class ActivitiesController < ApplicationController
  def index
      @activities = PublicActivity::Activity.order("created_at desc")
      @users = User.where(is_private = false).order(created_at: :desc).all
      @following_activities = PublicActivity::Activity.order("created_at desc").where(owner_type: "User", owner_id: current_user.following.map {|u| u.id}).all
  end
end
