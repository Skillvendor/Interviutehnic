json.array!(@variants) do |variant|
  json.extract! variant, :id, :is_active, :price, :quantity
  json.url variant_url(variant, format: :json)
end
