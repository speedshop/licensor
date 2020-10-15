class CheckoutsController < ApplicationController
  ALLOWED_ORIGIN = Rails.env.development? ? "*" : "speedshop.co"
  DOMAIN = Rails.env.development? ? "localhost:8080" : "speedshop.co"
  before_action :set_cors

  def create
    session = Stripe::Checkout::Session.create({
      payment_method_types: ["card"],
      line_items: [{
        price_data: {
          currency: "usd",
          product_data: {
            name: "Rails Performance Workshop (Single-User License)"
          },
          unit_amount: 50000
        },
        quantity: params[:quantity].empty? ? 1 : params[:quantity]
      }],
      mode: "payment",
      # For now leave these URLs as placeholder values.
      #
      # Later on in the guide, you'll create a real success page, but no need to
      # do it yet.
      success_url: "https://#{DOMAIN}/rpw_checkout_success.html",
      cancel_url: "https://#{DOMAIN}/rails-performance-workshop.html"
    })

    render json: {id: session.id}
  end

  private

  def set_cors
    response.set_header(
      "Access-Control-Allow-Origin",
      ALLOWED_ORIGIN
    )
  end
end
