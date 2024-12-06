class PaymentsController < ApplicationController
  def create
    @order = Order.find(params[:order_id])

    # Configure Stripe Checkout session
    session = Stripe::Checkout::Session.create(
      payment_method_types: [ "card" ],
      line_items: @order.order_details.map do |detail|
        {
          price_data: {
            currency: "usd",
            product_data: {
              name: detail.menu.name
            },
            unit_amount: (detail.price * 100).to_i # Convert dollars to cents
          },
          quantity: detail.quantity
        }
      end,
      mode: "payment",
      success_url: success_payment_url(@order.id),
      cancel_url: cancel_payment_url(@order.id)
    )

    # Save the session ID to the order (optional)
    @order.update(stripe_session_id: session.id)

    # Redirect to Stripe Checkout
    redirect_to session.url, allow_other_host: true
  end

  def success
    @order = Order.find(params[:id])
    @order.update(status: "paid")
    # Render success page or redirect
  end

  def cancel
    @order = Order.find(params[:id])
    @order.update(status: "canceled")
    # Render cancel page or redirect
  end
end
