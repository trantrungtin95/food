require "application_system_test_case"

class CouponCodesTest < ApplicationSystemTestCase
  setup do
    @coupon_code = coupon_codes(:one)
  end

  test "visiting the index" do
    visit coupon_codes_url
    assert_selector "h1", text: "Coupon Codes"
  end

  test "creating a Coupon code" do
    visit coupon_codes_url
    click_on "New Coupon Code"

    fill_in "Coupon code", with: @coupon_code.coupon_code
    fill_in "Restaurant", with: @coupon_code.restaurant_id
    click_on "Create Coupon code"

    assert_text "Coupon code was successfully created"
    click_on "Back"
  end

  test "updating a Coupon code" do
    visit coupon_codes_url
    click_on "Edit", match: :first

    fill_in "Coupon code", with: @coupon_code.coupon_code
    fill_in "Restaurant", with: @coupon_code.restaurant_id
    click_on "Update Coupon code"

    assert_text "Coupon code was successfully updated"
    click_on "Back"
  end

  test "destroying a Coupon code" do
    visit coupon_codes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Coupon code was successfully destroyed"
  end
end
