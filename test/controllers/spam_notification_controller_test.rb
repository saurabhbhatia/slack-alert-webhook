require "test_helper"

class SpamNotificationControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get spam_notification_create_url
    assert_response :success
  end
end
