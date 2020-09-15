require "application_system_test_case"

class ShippersTest < ApplicationSystemTestCase
  setup do
    @shipper = shippers(:one)
  end

  test "visiting the index" do
    visit shippers_url
    assert_selector "h1", text: "Shippers"
  end

  test "creating a Shipper" do
    visit shippers_url
    click_on "New Shipper"

    fill_in "User", with: @shipper.user_id
    click_on "Create Shipper"

    assert_text "Shipper was successfully created"
    click_on "Back"
  end

  test "updating a Shipper" do
    visit shippers_url
    click_on "Edit", match: :first

    fill_in "User", with: @shipper.user_id
    click_on "Update Shipper"

    assert_text "Shipper was successfully updated"
    click_on "Back"
  end

  test "destroying a Shipper" do
    visit shippers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shipper was successfully destroyed"
  end
end
