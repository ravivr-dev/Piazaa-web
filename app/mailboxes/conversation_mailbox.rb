class ConversationMailbox < ApplicationMailbox

  before_processing :decode_identifier
  before_processing :require_conversation

  def process
    parser = Messages::EmailResponseParser.new(mail)

    @conversation.messages.create(
      body: parser.parsed_body,
      from: @from,
      sender: sender
    )
  end

  private

    def decode_identifier
      @conversation, @from =
        Message.decode_email_reply_identifier(signed_identifer)
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      bounce_with_error_email
    end

    def require_conversation
      bounce_with_error_email unless @conversation.present?
    end

    def bounce_with_error_email
      bounce_with \
        ConversationMailer.email_response_error(mail.from.first)
    end

    def signed_identifer
      mail.recipients.find do |recipient|
        /conversation/.match? recipient
      end.split("@").first.split("+").second
    end

    def sender
      User.find_by(email: mail.from.first)
    end
end