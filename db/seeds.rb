# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb


# Clear existing data to avoid conflicts
Menu.destroy_all
Category.destroy_all
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
  Category.create!(name: category_name)
end

# Confirm categories were created
if Category.count == 4
  puts "Categories created successfully."
else
  puts "Error creating categories."
  exit
end

# Seed 100 menu items
100.times do
  Menu.create!(
    name: Faker::Food.dish,
    description: Faker::Food.description,
    price: Faker::Commerce.price(range: 5.0..25.0),
    category: categories.sample, # Assign a random category from those created
    availability_status: [ true, false ].sample # Randomly set availability
  )
end

puts "Seeded 100 African menu items successfully!"
