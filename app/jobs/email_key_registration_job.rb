class EmailKeyRegistrationJob < ActiveJob::Base
  ZAPIER_HOOK_URL = ENV["ZAPIER_HOOK_URL"]

  def perform(key, email)
    Typhoeus::Request.post(
      ZAPIER_HOOK_URL,
      body: {
        "email": email
      }.to_json
    )
  end
end
