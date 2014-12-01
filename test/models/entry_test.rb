require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    # This code is not idiomatically correct.
    @entry = @user.entries.build(title: "Title of entry ", content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @entry.valid?
  end

  test "user id should be present" do
    @entry.user_id = nil
    assert_not @entry.valid?
  end

  test "title should be present " do
    @entry.title = "   "
    assert_not @entry.valid?
  end

  test "title should be at most 55 characters " do
    @entry.title = "a" * 56
    assert_not @entry.valid?
  end

  test "content should be present " do
    @entry.content = "   "
    assert_not @entry.valid?
  end

  test "content should be at most 600 characters" do
    @entry.content = "a" * 601
    assert_not @entry.valid?
  end

end
