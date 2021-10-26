require "test_helper"

class CheckoutsControllerTest < ActionDispatch::IntegrationTest
  test "a single checkout" do
    assert_enqueued_jobs 0
    post rpw_checkout_url
    assert_response :success

    body = JSON.parse(response.body)
    assert body["id"]
  end
end
