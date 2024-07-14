require "application_system_test_case"

class VitalsTest < ApplicationSystemTestCase
  setup do
    @vital = vitals(:one)
  end

  test "visiting the index" do
    visit vitals_url
    assert_selector "h1", text: "Vitals"
  end

  test "should create vital" do
    visit vitals_url
    click_on "New vital"

    fill_in "Name", with: @vital.name
    fill_in "Weight", with: @vital.weight
    click_on "Create Vital"

    assert_text "Vital was successfully created"
    click_on "Back"
  end

  test "should update Vital" do
    visit vital_url(@vital)
    click_on "Edit this vital", match: :first

    fill_in "Name", with: @vital.name
    fill_in "Weight", with: @vital.weight
    click_on "Update Vital"

    assert_text "Vital was successfully updated"
    click_on "Back"
  end

  test "should destroy Vital" do
    visit vital_url(@vital)
    click_on "Destroy this vital", match: :first

    assert_text "Vital was successfully destroyed"
  end
end
