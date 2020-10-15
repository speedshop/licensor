class StripeWebhooksController < ApplicationController
  ENDPOINT_SECRET = ENV["STRIPE_WEBHOOK_SECRET"]

  def create
    payload = request.body.read
    sig_header = request.headers["Stripe-Signature"]
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError
      # Invalid payload
      render status: :bad_request
    rescue Stripe::SignatureVerificationError
      # Invalid signature
      render status: :bad_request
    end

    # Handle the event
    case event.type
    when "payment_intent.succeeded"
      # payment_intent = event.data.object # contains a Stripe::PaymentIntent
      puts "PaymentIntent was successful!"
    when "payment_method.attached"
      # payment_method = event.data.object # contains a Stripe::PaymentMethod
      puts "PaymentMethod was attached to a Customer!"
    # ... handle other event types
    else
      puts "Unhandled event type: #{event.type}"
    end

    status 200
  end
end
