class Recipe < ActiveRecord::Base
    
    validates_presence_of :author, :instructions, :servings
    validates :name, presence: true, uniqueness: true, length: { minimum: 5, maximum: 80 }
    
end
