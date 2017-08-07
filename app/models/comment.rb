class Comment < ActiveRecord::Base
  belongs_to :recipe
  accepts_nested_attributes_for :recipe, allow_destroy: true
  belongs_to :user
  include PublicActivity::Common
  # tracked except: :update, owner: ->(controller, model) { controller && controller.current_user }
end
