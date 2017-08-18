json.array!(@ingredients) do |ingredient|
  json.extract! ingredient, :category, :name, :quantity, :measurement
  json.url ingredient_url(ingredient, format: :json)
end
