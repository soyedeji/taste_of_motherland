# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create Customers
customer = Customer.create(name: "John Doe", email: "john@example.com", address: "123 Main St", phone_number: "123-456-7890")

# Create Menus
menu1 = Menu.create(name: "Jollof Rice", description: "Delicious rice with tomato sauce", price: 12.99, category: "Main Course", availability_status: true)
menu2 = Menu.create(name: "Fried Plantains", description: "Crispy fried plantains", price: 4.99, category: "Appetizer", availability_status: true)

# Create an Order
order = Order.create(customer: customer, order_date: Date.today, total_amount: 17.98, status: "Pending")

# Create Order Details
OrderDetail.create(order: order, menu: menu1, quantity: 1, price: 12.99)
OrderDetail.create(order: order, menu: menu2, quantity: 1, price: 4.99)

# Create a Payment
Payment.create(order: order, payment_date: Date.today, payment_amount: 17.98, status: "Completed")
