# Clear existing data to avoid conflicts
Menu.destroy_all
Category.destroy_all
Customer.destroy_all

# Ensure that Devise is available for creating encrypted passwords
require 'devise'

# Create a default admin if it doesn't exist
admin_email = 'admin@example.com'
admin_password = 'password123'

if Admin.find_by(email: admin_email).nil?
  Admin.create!(email: admin_email, password: admin_password, password_confirmation: admin_password)
  puts "Admin user created with email: #{admin_email} and password: #{admin_password}"
else
  puts "Admin user already exists with email: #{admin_email}"
end

require 'faker'

# Create categories
categories = %w[Appetizer Dessert Main\ Course Snacks].map do |category_name|
  Category.find_or_create_by!(name: category_name)
end

# Confirm categories were created
if Category.count == 4
  puts "Categories created successfully."
else
  puts "Error creating categories."
  exit
end

# Seed 100 unique menu items
unique_dishes = Set.new

while unique_dishes.size < 20
  unique_dishes.add(Faker::Food.dish)
end

unique_dishes.each do |dish|
  Menu.create!(
    name: dish,
    description: Faker::Food.description,
    price: Faker::Commerce.price(range: 5.0..25.0),
    category: categories.sample, # Assign a random category from those created
    availability_status: [ true, false ].sample # Randomly set availability
  )
end

puts "Seeded 100 African menu items successfully!"

# Sample customer data
customer_email = 'customer@example.com'
customer_password = 'password123'

# Create a sample customer for login
if Customer.find_by(email: customer_email).nil?
  Customer.create!(
    email: customer_email,
    password: customer_password,
    password_confirmation: customer_password,
    name: 'Sample Customer',
    address: '123 Test Street',
    province: 'Manitoba',
    postal_code: 'R3C 0V8'
  )
  puts "Sample customer created with email: #{customer_email} and password: #{customer_password}"
else
  puts "Sample customer already exists with email: #{customer_email}"
end
