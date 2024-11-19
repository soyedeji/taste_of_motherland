class CartController < ApplicationController
  def add_to_cart
    menu_id = params[:menu_id].to_i
    quantity = params[:quantity].to_i

    # Initialize the cart in the session if it doesn't exist
    session[:cart] ||= {}

    # Add or update the menu item in the cart
    if session[:cart][menu_id]
      session[:cart][menu_id] += quantity
    else
      session[:cart][menu_id] = quantity
    end

    redirect_to cart_path, notice: "Item added to cart successfully."
  end

  def update_quantity
    menu_id = params[:menu_id].to_i
    quantity = params[:quantity].to_i

    if quantity > 0
      session[:cart][menu_id] = quantity
    else
      session[:cart].delete(menu_id)
    end

    redirect_to cart_path, notice: "Quantity updated successfully."
  end

  def remove_item
    menu_id = params[:menu_id].to_s # Ensure matching key type
    Rails.logger.debug "Menu ID to remove: #{menu_id}"
    Rails.logger.debug "Cart before removal: #{session[:cart]}"
    session[:cart].delete(menu_id)
    Rails.logger.debug "Cart after removal: #{session[:cart]}"
    redirect_to cart_path, notice: "Item removed successfully."
  end

  def show
    cart = session[:cart] || {}
    @cart_items = cart.map do |menu_id, quantity|
      menu = Menu.find_by(id: menu_id)
      { menu: menu, quantity: quantity } if menu
    end.compact
  end
end
