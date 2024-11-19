class CartsController < ApplicationController
  def add_to_cart
    menu_id = params[:id].to_i
    quantity = params[:quantity].to_i

    session[:cart] ||= {}

    if session[:cart][menu_id]
      session[:cart][menu_id] += quantity
    else
      session[:cart][menu_id] = quantity
    end

    redirect_to cart_path, notice: "Item added to cart successfully."
  end

  def show
    cart = session[:cart] || {}
    @cart_items = cart.map do |menu_id, quantity|
      menu = Menu.find(menu_id)
      { menu: menu, quantity: quantity }
    end
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
    menu_id = params[:menu_id].to_i
    session[:cart].delete(menu_id)

    redirect_to cart_path, notice: "Item removed from cart."
  end
end
