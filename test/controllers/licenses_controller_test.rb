require "test_helper"

class LicensesControllerTest < ActionDispatch::IntegrationTest
  test "show" do
    get license_url

    assert_response 401
  end

  test "show with correct license" do
    get license_url, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(license_keys(:valid).key, '') }

    assert_response :success
  end

  test "unauth create" do
    post license_url, params: { key: "test" }, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials("nope", '') }

    assert_response 401
  end

  test "create" do
    post license_url, params: { key: "test" }, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials("admin", '') }

    assert_response :success
    assert LicenseKey.where(key: "test").exists?
  end

  test "unauth destroy" do
    delete license_url, params: { key: "mykey" }, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials("nope", '') }

    assert_response 401
  end

  test "destroy" do
    delete license_url, params: { key: "mykey" }, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials("admin", '') }

    assert_response :success
    refute LicenseKey.where(key: "mykey").exists?
  end

  test "update no key found" do
    put license_url, params: { key: "none", email: "test@test.com" }

    assert_response 404
  end

  test "update not successful" do
    key = license_keys(:email_changed)
    put license_url, params: { key: key.key, email: "test@test.com" }

    assert_response 403
  end

  test "update successful" do
    key = license_keys(:valid)
    put license_url, params: { key: key.key, email: "test@test.com" }

    assert_response 200
    key.reload

    assert_equal "test@test.com", key.email
    assert key.email_changed
    assert_enqueued_jobs 1
  end
end
