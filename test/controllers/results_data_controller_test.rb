require "test_helper"

class ResultsDataControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get results_data_create_url
    assert_response :success
  end
end
