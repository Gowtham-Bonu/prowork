require "test_helper"

class Freelancer::ProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get freelancer_profile_new_url
    assert_response :success
  end
end
