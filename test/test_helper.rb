ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

Stripe.api_key = "sk_test_123"
Stripe.api_base = "http://localhost:12111"
ENV["ADMIN_API_KEY"] = "admin"

class ActiveSupport::TestCase
  fixtures :all
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)
end
