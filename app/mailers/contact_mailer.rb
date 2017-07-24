class ContactMailer < ApplicationMailer

    def new_message(message)
      @message = message
      mail(to: ENV["PERSONAL_EMAIL"], subject: "Message From Sangria New York City Website")
    end

end
