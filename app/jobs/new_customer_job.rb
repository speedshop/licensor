class NewCustomerJob < ActiveJob::Base
  ZAPIER_HOOK_URL = ENV["ZAPIER_HOOK_URL"]

  def perform(checkout_session_id)
    session = Stripe::Checkout::Session.retrieve(
      id: checkout_session_id,
      expand: ["customer", "line_items"]
    )
    quantity = session.line_items.data.first.quantity
    customer = session.customer.to_h

    license_keys = quantity.times.map {
      LicenseKey.create!(email: customer[:email].downcase, key: LicenseKey.generate_key)
    }

    ContactMailer.with(
      email: customer[:email],
      license_key_ids: license_keys.map(&:id)
    ).workshop_sold_email.deliver_later

    # Send mailing list/slack Zapier trigger
    Typhoeus::Request.post(
      ZAPIER_HOOK_URL,
      body: {
        "email": customer[:email]
      }.to_json
    )
  end
end
