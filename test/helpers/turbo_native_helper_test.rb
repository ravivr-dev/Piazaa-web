require 'test_helper'

class TurboNativeHelperTest < ActionView::TestCase
  test "ios turbo native request" do
    @request.user_agent = "Turbo Native iOS"
    assert_equal "ios", turbo_native_bridge_platform
  end

  test "android turbo native request" do
    @request.user_agent = "Turbo Native Android"
    assert_equal "android", turbo_native_bridge_platform
  end

  test "non turbo native request" do
    assert_equal "", turbo_native_bridge_platform
  end
end