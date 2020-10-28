class EmailKeyRegistrationJob < ActiveJob::Base
  ZAPIER_HOOK_URL = ENV["ZAPIER_HOOK_URL"]

  def perform(key, email)
    license_key = LicenseKey.find_by(key: key)
    license_key.with_lock do
      return if license_key.email == email.downcase || license_key.email_changed
      license_key.email_changed = true
      license_key.email = email.downcase
      license_key.save!
    end

    Typhoeus::Request.post(
      ZAPIER_HOOK_URL,
      body: {
        "email": customer[:email]
      }.to_json
    )
  end
end
