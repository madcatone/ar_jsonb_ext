require 'test_helper'
require 'models/user'
require 'models/slide'
require 'models/company'

class ArJsonbExt::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, ArJsonbExt
  end
  test "user name and meta_info->'code' 'agent' 'bio'" do
    u = User.new
    u.name = 'John Wick'
    u.meta_info = {"code": '0X56', "agent": 'ios_app', "bio": '2018-01-01'}
    assert_equal "John Wick", u.name
    assert_equal "2018-01-01", u.bio
  end

  test "slide title and meta->'locale' 'color' 'size'" do
    u = Slide.new
    u.title = 'Financial Report'
    u.meta = {"locale": 'zh', "color": 'white', "size": '3XL'}
    assert_equal "Financial Report", u.title
    assert_equal "3XL", u.size
  end

  test "fixture user test" do
    u = user(:john_wick)
    assert_equal 'John Wick', u.name
  end

  test "fixture user jdeleted" do
    u = user(:nick_fury)
    assert_equal true, u.deleted?
  end

  test "fixture slide test" do
    u = slide(:exchange_report)
    assert_equal 'Exchange Report', u.title
  end

  test "fixture silde test meta deleted_at" do
    u = slide(:food_report)
    assert_equal true, u.deleted?
  end

  test "fixture company test" do
    u = company(:east_studio)
    assert_equal 'East Studio', u.name
  end

  test "fixture company test meta deleted_at" do
    u = company(:west_summit)
    assert_equal true, u.deleted?
  end

end
