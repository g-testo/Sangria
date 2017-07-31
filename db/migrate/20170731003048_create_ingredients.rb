class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :recipe_id
      t.string :name
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
