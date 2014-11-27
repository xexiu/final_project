require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  def setup
    @base_title = "VotesMe"
  end

  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "#{@base_title} | Help"
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "#{@base_title} | Contact"
  end

  test "should get tos" do
    get :tos
    assert_response :success
    assert_select "title", "#{@base_title} | TOS"
  end

end
