class Message < ApplicationRecord
  include EmailRespondable, ActionView::RecordIdentifier

  belongs_to :conversation
  belongs_to :from, class_name: "Organization"
  belongs_to :sender, class_name: "User", optional: true

  validates :body, presence: true

  scope :for_display, -> {
    includes(:from, :sender)
    .where.not(created_at: nil)
    .order(created_at: :asc)
  }

  after_create_commit -> {
    broadcast_append_later_to(
      conversation,
      target: dom_id(conversation, :messages),
      locals: { from: from.id }
    )
  }

  after_create_commit -> {
    conversation.notify_recipient(self)
  }
end