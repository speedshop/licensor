require "test_helper"

class GumroadWebhooksControllerTest < ActionDispatch::IntegrationTest
  test "unauth checkout" do
    post gumroad_hook_url, params: { email: "test@testeroni.com", product: "sip"}, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials("test", '') }
    assert_response 401
  end

  test "a checkout" do
    post gumroad_hook_url, params: { email: "test@testeroni.com", product: "sip"}, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials("admin", '') }
    assert_response :success
    assert_equal 1, LicenseKey.where(email: "test@testeroni.com", product: "sip").count
  end
end
