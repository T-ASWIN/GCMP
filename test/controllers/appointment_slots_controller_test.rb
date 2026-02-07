require "test_helper"

class AppointmentSlotsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get appointment_slots_index_url
    assert_response :success
  end
end
