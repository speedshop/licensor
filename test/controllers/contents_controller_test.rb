require "test_helper"

class ContentsControllerTest < ActionDispatch::IntegrationTest
  test "unauthenticated" do
    get contents_url

    body = JSON.parse(response.body)
    assert_equal "Welcome to the Workshop", body.first["title"]
    assert_equal 86, body.size
    assert_equal Content.order(:position).first.position, body.first["position"]
    refute body.first["url"]
  end

  test "authenticated" do
    get contents_url, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(license_keys(:valid).key, '') }

    body = JSON.parse(response.body)
    assert body.first["url"].start_with?("https://speedshop-rpw.s3-accelerate.amazonaws.com")
  end
end
