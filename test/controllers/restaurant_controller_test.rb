require 'test_helper'

class RestaurantControllerTest < ActionDispatch::IntegrationTest
  test "should get name:string" do
    get restaurant_name:string_url
    assert_response :success
  end

  test "should get address:string" do
    get restaurant_address:string_url
    assert_response :success
  end

  test "should get open_time:string" do
    get restaurant_open_time:string_url
    assert_response :success
  end

  test "should get close_time:string" do
    get restaurant_close_time:string_url
    assert_response :success
  end

end
