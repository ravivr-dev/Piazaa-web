class Conversations::Notification < ApplicationRecord
  include Readable

  belongs_to :conversation
  belongs_to :message
  belongs_to :recipient, class_name: "Organization"

  after_create_commit :deliver_by_email

  private

    def deliver_by_email
      to = recipient.members.first

      ConversationMailer.new_message(
        message,
        to: to,
        reply_to: message.response_email(recipient)
      ).deliver_later
    end
end
