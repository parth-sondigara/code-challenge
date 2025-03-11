# Clear existing data
User.destroy_all
Product.destroy_all
Order.destroy_all

# Create Users
user1 = User.create!(name: "alice", email: "alice@example.com")
user2 = User.create!(name: "Bob", email: "bob@example.com")

# Create Products
product1 = Product.create!(name: "Laptop", price: 1000.00)
product2 = Product.create!(name: "Phone", price: 500.00)

# Create Orders
Order.create!(user: user1, product: product1, quantity: 2, total_price: 2000.00)
Order.create!(user: user2, product: product2, quantity: 1, total_price: 500.00)
