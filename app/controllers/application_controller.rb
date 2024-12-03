class ApplicationController < ActionController::Base
  before_action :ensure_single_session

  private

  def ensure_single_session
    if admin_signed_in? && customer_signed_in?
      sign_out(:customer) # Log out the customer when admin is logged in
    elsif customer_signed_in? && admin_signed_in?
      sign_out(:admin) # Log out the admin when customer is logged in
    end
  end
end
