require "test_helper"

class VitalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vital = vitals(:one)
  end

  test "should get index" do
    get vitals_url
    assert_response :success
  end

  test "should get new" do
    get new_vital_url
    assert_response :success
  end

  test "should create vital" do
    assert_difference("Vital.count") do
      post vitals_url, params: { vital: { name: @vital.name, weight: @vital.weight } }
    end

    assert_redirected_to vital_url(Vital.last)
  end

  test "should show vital" do
    get vital_url(@vital)
    assert_response :success
  end

  test "should get edit" do
    get edit_vital_url(@vital)
    assert_response :success
  end

  test "should update vital" do
    patch vital_url(@vital), params: { vital: { name: @vital.name, weight: @vital.weight } }
    assert_redirected_to vital_url(@vital)
  end

  test "should destroy vital" do
    assert_difference("Vital.count", -1) do
      delete vital_url(@vital)
    end

    assert_redirected_to vitals_url
  end
end
