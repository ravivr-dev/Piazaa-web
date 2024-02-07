require "test_helper"

class Conversation::NotifierTest < ActiveSupport::TestCase
  setup do
    @to = organizations(:jerry)
    @conversation = conversations(:kramer_jerry_1)
    @message = messages(:kramer_jerry_1_3)
  end

  test "creates notification for offline participant" do
    assert_difference "Conversations::Notification.count", 1 do
      @conversation.notify_recipient(@message)
    end

    assert_equal @to, Conversations::Notification.last.recipient
  end

  test "does not create notification for online participant" do
    @conversation.online_participants << @to.id

    assert_no_difference "Conversations::Notification.count" do
      @conversation.notify_recipient(@message)
    end
  end
end