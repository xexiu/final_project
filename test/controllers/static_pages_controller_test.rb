require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "VotesMe | Home"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "VotesMe | Help"
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "VotesMe | Contact"
  end

  test "should get tos" do
    get :tos
    assert_response :success
    assert_select "title", "VotesMe | TOS"
  end

end
