class ApplicationMailbox < ActionMailbox::Base
  routing /^conversation\+(\S+)@/i => :conversation
end
