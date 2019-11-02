require 'test_helper'

class JoinersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @joiner = joiners(:one)
  end

  test "should get index" do
    get joiners_url
    assert_response :success
  end

  test "should get new" do
    get new_joiner_url
    assert_response :success
  end

  test "should create joiner" do
    assert_difference('Joiner.count') do
      post joiners_url, params: { joiner: { sharer: @joiner.sharer } }
    end

    assert_redirected_to joiner_url(Joiner.last)
  end

  test "should show joiner" do
    get joiner_url(@joiner)
    assert_response :success
  end

  test "should get edit" do
    get edit_joiner_url(@joiner)
    assert_response :success
  end

  test "should update joiner" do
    patch joiner_url(@joiner), params: { joiner: { sharer: @joiner.sharer } }
    assert_redirected_to joiner_url(@joiner)
  end

  test "should destroy joiner" do
    assert_difference('Joiner.count', -1) do
      delete joiner_url(@joiner)
    end

    assert_redirected_to joiners_url
  end
end
