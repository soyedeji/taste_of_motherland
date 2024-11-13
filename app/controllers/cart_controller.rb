# app/controllers/cart_controller.rb
class CartController < ApplicationController
  def add_to_cart
    menu_id = params[:id].to_i
    quantity = params[:quantity].to_i

    # Initialize the cart in the session if it doesn't exist
    session[:cart] ||= {}

    # Add or update item quantity in the cart
    if session[:cart][menu_id]
      session[:cart][menu_id] += quantity
    else
      session[:cart][menu_id] = quantity
    end

    redirect_to cart_path, notice: "Item added to cart successfully."
  end

  def show
    # Retrieve cart items and associated menu items from the session
    cart = session[:cart] || {}
    @cart_items = cart.map do |menu_id, quantity|
      menu = Menu.find(menu_id)
      { menu: menu, quantity: quantity }
    end
  end
end
