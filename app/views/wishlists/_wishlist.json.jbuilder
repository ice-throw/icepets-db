json.extract! wishlist, :id, :name, :description, :privacy, :sorting, :user_id, :created_at, :updated_at
json.url wishlist_url(wishlist, format: :json)