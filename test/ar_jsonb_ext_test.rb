require 'test_helper'
require 'models/user'
require 'models/slide'

class ArJsonbExt::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, ArJsonbExt
  end
  test "user name and meta_info" do
    u = User.new
    u.name = 'John Wick'
    u.meta_info = {"enabled": true, "feedback_notifyees": 3, "presentable_update_time": '2018-01-01'}
    assert_equal "John Wick", u.name
    assert_equal "2018-01-01", u.presentable_update_time
  end

  test "slide title and meta" do
    u = Slide.new
    u.title = 'Financial Report'
    u.meta = {"enabled": true, "feedback_notifyees": 3, "presentable_update_time": '2018-01-01'}
    assert_equal "Financial Report", u.title
    assert_equal "2018-01-01", u.presentable_update_time
  end

  test "fixture user test" do
    u = user(:john_wick)
    assert_equal 'John Wick', u.name
  end

  test "fixture user jdeleted" do
    u = user(:nick_fury)
    assert_equal true, u.deleted?
  end
end
