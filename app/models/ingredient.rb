class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  accepts_nested_attributes_for :recipe, allow_destroy: true
  before_save :downcase_fields

  def downcase_fields
    self.category.downcase!
    self.name.downcase!
  end
end
