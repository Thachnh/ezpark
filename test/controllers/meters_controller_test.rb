require 'test_helper'

class MetersControllerTest < ActionController::TestCase
  setup do
    @meter = meters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meter" do
    assert_difference('Meter.count') do
      post :create, meter: { block_id: @meter.block_id, lat: @meter.lat, long: @meter.long, rate: @meter.rate, status: @meter.status }
    end

    assert_redirected_to meter_path(assigns(:meter))
  end

  test "should show meter" do
    get :show, id: @meter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @meter
    assert_response :success
  end

  test "should update meter" do
    patch :update, id: @meter, meter: { block_id: @meter.block_id, lat: @meter.lat, long: @meter.long, rate: @meter.rate, status: @meter.status }
    assert_redirected_to meter_path(assigns(:meter))
  end

  test "should destroy meter" do
    assert_difference('Meter.count', -1) do
      delete :destroy, id: @meter
    end

    assert_redirected_to meters_path
  end
end
