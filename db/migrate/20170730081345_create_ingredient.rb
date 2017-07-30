class CreateIngredient < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :recipe_id
      t.string :item_id
    end
  end
end
