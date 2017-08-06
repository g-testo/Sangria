json.array!(@recipes) do |recipe|
  json.extract! recipe, :name, :author, :servings, :instructions
  json.url recipe_url(recipe, format: :json)
end
