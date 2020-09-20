require 'test_helper'

class ShipperOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get shipper_id:integer" do
    get shipper_orders_shipper_id:integer_url
    assert_response :success
  end

  test "should get order_id:integer" do
    get shipper_orders_order_id:integer_url
    assert_response :success
  end

  test "should get status:string" do
    get shipper_orders_status:string_url
    assert_response :success
  end

end
