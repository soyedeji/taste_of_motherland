class ApplicationController < ActionController::Base
  before_action :initialize_cart
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # Ensure the shopping cart is always initialized
  def initialize_cart
    session[:cart] ||= {}
  end

  # Allow additional parameters for Devise (address and province)
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :address, :province ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :address, :province ])
  end
end
