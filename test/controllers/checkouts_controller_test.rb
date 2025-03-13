require "test_helper"

class CheckoutsControllerTest < ActionDispatch::IntegrationTest
  test "a single checkout" do
    mock_class = Class.new do
      def self.create(*)
        Struct.new(:id).new("mock_session_id")
      end
    end

    stub_const(Stripe::Checkout, :Session, mock_class) do
      assert_enqueued_jobs 0
      post rpw_checkout_url
      assert_response :success

      body = JSON.parse(response.body)
      assert_equal "mock_session_id", body["id"]
    end
  end
end
