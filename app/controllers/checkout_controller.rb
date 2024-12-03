class CheckoutController < ApplicationController
  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.find_or_initialize_by(name: customer_params[:name])
    if @customer.update(customer_params) # Use strong parameters
      # Create an order for the customer
      order = @customer.orders.create(total_amount: calculate_total_price) # Use total_amount as per schema

      # Add order details for each item in the cart
      session[:cart].each do |menu_id, quantity|
        menu = Menu.find(menu_id)
        order.order_details.create!(
          menu: menu,
          quantity: quantity,
          price: menu.price
        )
      end

      # Clear the cart after checkout
      session[:cart] = nil

      # Redirect to the order summary page with success message
      redirect_to order_path(order), notice: "Order placed successfully!"
    else
      flash.now[:alert] = "There was an issue with your order. Please ensure all details are correct."
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details

    # Calculate subtotal
    @subtotal = @order_details.sum { |detail| detail.price * detail.quantity }

    # Define tax rates
    tax_rates = {
      "Ontario" => { gst: 0.05, pst: 0.08, hst: 0.13 },
      "Manitoba" => { gst: 0.05, pst: 0.07, hst: 0.00 },
      "Quebec" => { gst: 0.05, pst: 0.09975, hst: 0.00 }
    }

    # Get the tax rate for the customer's province
    province = @order.customer.province
    rates = tax_rates[province] || { gst: 0.05, pst: 0.00, hst: 0.00 }

    # Calculate taxes
    @gst = @subtotal * rates[:gst]
    @pst = @subtotal * rates[:pst]
    @hst = @subtotal * rates[:hst]

    # Calculate total including taxes
    @total_with_taxes = @subtotal + @gst + @pst + @hst
  end

  private

  # Strong parameters
  def customer_params
    params.require(:customer).permit(:name, :address, :province)
  end

  # Calculate total price including taxes
  def calculate_total_price
    # Ensure the cart is initialized
    cart = session[:cart] || {}

    # Calculate subtotal
    subtotal = cart.sum do |menu_id, quantity|
      menu = Menu.find(menu_id)
      menu.price * quantity
    end

    # Define tax rates
    tax_rates = {
      "Ontario" => 0.13,
      "Manitoba" => 0.12,
      "Quebec" => 0.14975
    }

    # Determine tax rate based on customer's province
    tax_rate = tax_rates[@customer.province] || 0

    # Return total price including taxes
    subtotal + (subtotal * tax_rate)
  end
end
