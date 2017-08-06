json.array!(@comments) do |comment|
  json.extract! comment, :body, :recipe_id, :user_id
  json.url comment_url(comment, format: :json)
end
