class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :author
      t.integer :servings
      t.string :instructions

      t.timestamps null: false
    end
  end
end
