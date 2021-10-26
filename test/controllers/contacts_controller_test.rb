require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should post an email" do
    assert_enqueued_jobs 0
    post rpw_contact_url, params: { data: "nate.berkopec@speedshop.co" }
    assert_redirected_to ContactsController::SUCCESS_URL
    assert_enqueued_jobs 1
  end
end
