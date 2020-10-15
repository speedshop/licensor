class EmailKeyRegistrationJob < ActiveJob::Base 
  def perform(key, email)
    # With lock: update key registration 
      # Update email
      # Send webhooks:
        # Adding to mailing list 
        # Adding to Slack 
  end
end