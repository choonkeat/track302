require 'test_helper'

module Track302
  class RedirectControllerTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
      @original_url = "http://www.google.com/one/two%20three?q=123#anchor456"
      @link = Link.create(original: @original_url)
      @referrer_url = "https://yahoo.com/abc?xyz=123"
      @request.env['HTTP_REFERER'] = @referrer_url
      @remote_ip = "8.8.8.2"
      @request.env['REMOTE_ADDR'] = @remote_ip
    end

    test "should 404 on unknown link" do
      get :show, uuid: "wrong" + @link.uuid, path: URI.parse(@original_url).path
      assert_response :not_found
    end

    test "should get redirected to original_url" do
      get :show, uuid: @link.uuid, path: URI.parse(@original_url).path
      assert_redirected_to @original_url
    end

    test "should track clickthrough data" do
      assert_difference -> { Click.where(uuid: @link.uuid).count }, 1 do
        get :show, uuid: @link.uuid, path: URI.parse(@original_url).path
      end
      click = Click.last
      assert_equal @referrer_url, click.data['HTTP_REFERER']
      assert_equal @remote_ip, click.data['REMOTE_ADDR']
    end
  end
end
