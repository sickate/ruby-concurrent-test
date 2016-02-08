json.array!(@posts) do |post|
  json.extract! post, :id, :content, :title, :published_at
  json.url post_url(post, format: :json)
end
