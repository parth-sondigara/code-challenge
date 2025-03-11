FactoryBot.define do
  factory :order do
    user
    product
    quantity { rand(1..5) }
    total_price { product.price * quantity }
  end
end
