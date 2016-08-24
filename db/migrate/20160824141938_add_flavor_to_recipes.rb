class AddFlavorToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :flavor, :string
  end
end
