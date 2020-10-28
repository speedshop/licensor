class StripeWebhooksController < ApplicationController
  ENDPOINT_SECRET = ENV["STRIPE_WEBHOOK_SECRET"]

  def create
    begin
      event = Stripe::Webhook.construct_event(
        request.body.read, 
        request.headers["Stripe-Signature"], 
        ENDPOINT_SECRET
      )
    rescue JSON::ParserError
      render status: :bad_request
    rescue Stripe::SignatureVerificationError
      render status: :bad_request
    end

    case event.type
    when "checkout.session.completed"
      NewCustomerJob.perform_later(event.data.object.id)
    else
      puts "Unhandled event type: #{event.type}"
    end

    render status: :ok
  end
end
