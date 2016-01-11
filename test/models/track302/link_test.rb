require 'test_helper'

module Track302
  class LinkTest < ActiveSupport::TestCase
    setup do
      @original_url = "http://www.google.com/one/two%20three?q=123#anchor456"
      @link = Link.create(original: @original_url)
    end

    test "stores original_url" do
      assert_equal @original_url, @link.original
    end

    test "autogenerate uuid" do
      assert @link.uuid, "should not be blank"
    end

    test "autogenerate uuid even if provided" do
      other_link = Link.create(original: @original_url, uuid: @link.uuid)
      assert other_link.uuid, "should not be blank"
      assert_not_equal @link.uuid, other_link.uuid
    end
  end
end
