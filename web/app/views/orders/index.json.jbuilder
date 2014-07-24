json.array!(@orders) do |order|
  json.extract! order, :id, :employee, :items
  json.url order_url(order, format: :json)
end
