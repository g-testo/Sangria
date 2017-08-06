class MessagesController < ApplicationController
  before_filter :check_logged_in, only: [:create, :new]

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @user = current_user
    if @message.valid? && verify_recaptcha(model: @message)
      ContactMailer.new_message(@message).deliver_now
      redirect_to contact_path, notice: "Your messages has been sent."
    else
      flash[:alert] = "An error occurred while delivering this message."
      render :new
    end
  end

private

  def message_params
    params.require(:message).permit(:name, :email, :content, :subject, :mobile)
  end
end
