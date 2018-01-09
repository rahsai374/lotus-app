json.extract! product, :id, :name, :amount, :email, :user_name, :created_at, :updated_at
json.url product_url(product, format: :json)
