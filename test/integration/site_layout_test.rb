require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 1
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", contact_path
    get signup_path
    assert_select "title", "VotesMe | Sign up"
  end
end
