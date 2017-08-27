class ChangeDataFormatRecipeIdInIngredients < ActiveRecord::Migration
  def change
    change_column :ingredients, :recipe_id, 'integer USING CAST(recipe_id AS integer)'
  end
end
