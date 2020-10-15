json.extract! coupon_code, :id, :restaurant_id, :coupon_code, :created_at, :updated_at, :end_date, :status
json.url coupon_code_url(coupon_code, format: :json)
