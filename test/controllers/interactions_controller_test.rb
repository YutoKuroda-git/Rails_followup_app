require "test_helper"

class InteractionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get interactions_index_url
    assert_response :success
  end
end
