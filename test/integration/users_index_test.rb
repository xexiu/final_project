require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "index including pagination" do
    log_in_as(@user)
    get users_path(@user)
    assert_template 'users/index'
    assert_select 'div.pagination'
    assert_select "a[href=?]", user_path(@user)
  end

end
