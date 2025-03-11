class ProductSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :price, :created_at, :updated_at
end
