json.extract! restaurant, :id, :name, :user_id, :address, :open_time, :close_time, :created_at, :updated_at
json.url restaurant_url(restaurant, format: :json)
