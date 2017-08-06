class Comment < ActiveRecord::Base
  belongs_to :recipe
  accepts_nested_attributes_for :recipe, allow_destroy: true
  belongs_to :user
end
