class Recipe < ActiveRecord::Base
    mount_uploader :recipe_image, RecipeImageUploader
    # validates_presence_of :author, :instructions, :servings
    # validates :name, presence: true, uniqueness: true, length: { minimum: 5, maximum: 80 }
    validate :recipe_image_size
    belongs_to :user
    
    private
    
    def recipe_image_size
      if recipe_image.size > 5.megabytes
        errors.add(:recipe_image, "should be less than 5MB")
      end
    end
end
