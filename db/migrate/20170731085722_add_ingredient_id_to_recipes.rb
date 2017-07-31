class AddIngredientIdToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :ingredient_id, :integer
    add_index  :recipes, :ingredient_id
  end
end
