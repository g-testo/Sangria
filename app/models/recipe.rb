class Recipe < ActiveRecord::Base
  has_many :ratings
  belongs_to :user
  has_many :comments, as: :commentable
  mount_uploader :recipe_image, RecipeImageUploader
  validates_presence_of :author, :instructions, :servings
  validates :name, presence: true, length: { minimum: 5, maximum: 80 }
  validates :user_id, presence: true
  validate :recipe_image_size

  def average_rating
    ratings.sum(:score) / ratings.size
  end

  private

  def recipe_image_size
    if recipe_image.size > 5.megabytes
      errors.add(:recipe_image, "should be less than 5MB")
    end
  end
end
