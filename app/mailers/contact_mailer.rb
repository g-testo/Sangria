class ContactMailer < ApplicationMailer

  default from: "<" + ENV["FROM_EMAIL"] + ">"
  default to: "<" + ENV["PERSONAL_EMAIL"] + ">"

    def new_message(message)
      @message = message
    end


end
