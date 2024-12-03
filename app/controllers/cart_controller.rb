class CartController < ApplicationController
  def add_to_cart
    menu_id = params[:menu_id].to_i
    quantity = params[:quantity].to_i

    # Initialize the cart in the session if it doesn't exist
    session[:cart] ||= {}

    # Add or update the menu item in the cart
    if session[:cart][menu_id]
      session[:cart][menu_id] += quantity
      flash[:notice] = "Item quantity updated in cart."
    else
      session[:cart][menu_id] = quantity
      flash[:notice] = "Item added to cart successfully."
    end

    redirect_to cart_path
  end

  def update_quantity
    menu_id = params[:menu_id].to_i
    quantity = params[:quantity].to_i

    if quantity > 0
      session[:cart][menu_id] = quantity
      flash[:notice] = "Quantity updated successfully."
    else
      session[:cart].delete(menu_id)
      flash[:alert] = "Item removed because quantity was set to 0."
    end

    redirect_to cart_path
  end

  def remove_item
    menu_id = params[:menu_id].to_s # Ensure matching key type
    Rails.logger.debug "Menu ID to remove: #{menu_id}"
    Rails.logger.debug "Cart before removal: #{session[:cart]}"
    if session[:cart].delete(menu_id)
      flash[:notice] = "Item removed successfully."
    else
      flash[:alert] = "Item could not be removed. Please try again."
    end
    Rails.logger.debug "Cart after removal: #{session[:cart]}"
    redirect_to cart_path
  end

  def show
    cart = session[:cart] || {}
    @cart_items = cart.map do |menu_id, quantity|
      menu = Menu.find_by(id: menu_id)
      if menu
        { menu: menu, quantity: quantity }
      else
        session[:cart].delete(menu_id) # Remove invalid items from the cart
        nil
      end
    end.compact
  end
end
