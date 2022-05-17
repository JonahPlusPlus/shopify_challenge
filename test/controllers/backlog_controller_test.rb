require "test_helper"

class BacklogControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get backlog_index_url
    assert_response :success
  end
end
