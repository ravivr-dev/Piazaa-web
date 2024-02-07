require "test_helper"

class Conversations::NotificationTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  setup do
    @conversation = conversations(:kramer_jerry_1)
    @message = @conversation.messages.last
    @recipient = organizations(:kramer)
  end

  test "sends email notification after creation" do
    @conversation.notifications.create(
      message: @message,
      recipient: @recipient
    )

    assert_enqueued_email_with(
      ConversationMailer,
      :new_message,
      args: [
        @message,
        to: users(:kramer),
        reply_to: @message.response_email(@recipient)
      ]
    )
  end
end