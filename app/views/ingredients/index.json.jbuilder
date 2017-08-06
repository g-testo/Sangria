json.array!(@ingredients) do |ingredient|
  json.extract! ingredient, :category, :name, :quantity
  json.url ingredient_url(ingredient, format: :json)
end
