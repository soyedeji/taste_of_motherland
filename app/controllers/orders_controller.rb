class OrdersController < ApplicationController
  before_action :authenticate_customer! # Ensure the customer is logged in

  # List all past orders
  def index
    @orders = current_customer.orders.includes(order_details: :menu) # Correct association
  end
end
