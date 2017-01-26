require 'test_helper'

class RaritiesControllerTest < ActionController::TestCase
  setup do
    @rarity = rarities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rarities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rarity" do
    assert_difference('Rarity.count') do
      post :create, rarity: { name: @rarity.name }
    end

    assert_redirected_to rarity_path(assigns(:rarity))
  end

  test "should show rarity" do
    get :show, id: @rarity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rarity
    assert_response :success
  end

  test "should update rarity" do
    patch :update, id: @rarity, rarity: { name: @rarity.name }
    assert_redirected_to rarity_path(assigns(:rarity))
  end

  test "should destroy rarity" do
    assert_difference('Rarity.count', -1) do
      delete :destroy, id: @rarity
    end

    assert_redirected_to rarities_path
  end
end
