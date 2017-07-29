class AddAvgRatingToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :avg_rating, :integer
  end
end
