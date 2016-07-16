class Recipe < ActiveRecord::Base
    mount_uploader :image, RecipeImageUploader
    # validates_presence_of :author, :instructions, :servings
    # validates :name, presence: true, uniqueness: true, length: { minimum: 5, maximum: 80 }
    
end
