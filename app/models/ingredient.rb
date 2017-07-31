class Ingredient < ActiveRecord::Base
  # attr_accessor :name, :quantity
  belongs_to :recipe
end
