ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

Stripe.api_key = "sk_test_123"
Stripe.api_base = "http://localhost:12111"
ENV["ADMIN_API_KEY"] = "admin"

# Configure AWS SDK for testing
require "aws-sdk-s3"

Aws.config.update({
  region: "us-east-1",
  credentials: Aws::Credentials.new("testing", "testing")
})

# Mock S3 calls
unless ENV["REAL_AWS"] == "true"
  Aws.config[:s3] = {
    stub_responses: {
      put_object: ->(context) { {} },
      get_object: ->(context) {
        { body: StringIO.new("mock file content") }
      },
      delete_object: ->(context) { {} },
      head_object: ->(context) { {} }
    }
  }
end

class ActiveSupport::TestCase
  fixtures :all
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)
end
