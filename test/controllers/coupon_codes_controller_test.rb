require 'test_helper'

class CouponCodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coupon_code = coupon_codes(:one)
  end

  test "should get index" do
    get coupon_codes_url
    assert_response :success
  end

  test "should get new" do
    get new_coupon_code_url
    assert_response :success
  end

  test "should create coupon_code" do
    assert_difference('CouponCode.count') do
      post coupon_codes_url, params: { coupon_code: { coupon_code: @coupon_code.coupon_code, restaurant_id: @coupon_code.restaurant_id } }
    end

    assert_redirected_to coupon_code_url(CouponCode.last)
  end

  test "should show coupon_code" do
    get coupon_code_url(@coupon_code)
    assert_response :success
  end

  test "should get edit" do
    get edit_coupon_code_url(@coupon_code)
    assert_response :success
  end

  test "should update coupon_code" do
    patch coupon_code_url(@coupon_code), params: { coupon_code: { coupon_code: @coupon_code.coupon_code, restaurant_id: @coupon_code.restaurant_id } }
    assert_redirected_to coupon_code_url(@coupon_code)
  end

  test "should destroy coupon_code" do
    assert_difference('CouponCode.count', -1) do
      delete coupon_code_url(@coupon_code)
    end

    assert_redirected_to coupon_codes_url
  end
end
