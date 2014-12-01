require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    # This code is not idiomatically correct.
    @entry = Entry.new(content: "Lorem ipsum", user_id: @user.id)
  end

  test "should be valid" do
    assert @entry.valid?
  end

  test "user id should be present" do
    @entry.user_id = nil
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
