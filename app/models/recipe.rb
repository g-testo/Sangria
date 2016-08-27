class Recipe < ActiveRecord::Base
  belongs_to :user
  mount_uploader :recipe_image, RecipeImageUploader
  validates_presence_of :author, :instructions, :servings, :ingredients, :user_id
  validates :name, presence: true, uniqueness: true, length: { minimum: 5, maximum: 80 }
  validates :user_id, presence: true
  validate :recipe_image_size
  
    
  private
  
  def recipe_image_size
    if recipe_image.size > 5.megabytes
      errors.add(:recipe_image, "should be less than 5MB")
    end
  end
end
