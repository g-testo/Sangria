class ApplicationMailer < ActionMailer::Base
  default from: ENV["FROM_EMAIL"]
  default to: ENV["PERSONAL_EMAIL"]
  layout 'mailer'
end
