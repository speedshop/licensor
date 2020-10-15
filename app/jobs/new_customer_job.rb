class NewCustomerJob < ActiveJob::Base 
  def perform(checkout_session_id)
    session = Stripe::Checkout::Session.retrieve(
      id: checkout_session_id,
      expand: ["customer", "line_items"]
    )
    quantity = session.line_items.data.first.quantity

    license_keys = quantity.times do
      LicenseKey.create!(email: session.customer.email, key: LicenseKey.generate_key)
    end

    ContactMailer.with(
      customer: session.customer.to_h,
      license_key_ids: license_keys.map(&:id)
    ).workshop_sold_email.deliver_later
      
    # Send webhooks:
      # Adding to mailing list 
      # Adding to Slack 
  end
end