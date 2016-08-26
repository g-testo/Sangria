class AddIngredientsToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :ingredients, :string
  end
end
