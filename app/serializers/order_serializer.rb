class OrderSerializer
  include JSONAPI::Serializer

  attributes :id, :product, :quantity, :total_price, :user, :created_at, :updated_at
end
