class Ingredient < ActiveRecord::Base
  # attr_accessor :name, :quantity
  belongs_to :recipe
  before_save :downcase_fields

  def downcase_fields
    self.category.downcase!
    self.name.downcase!
  end
end
