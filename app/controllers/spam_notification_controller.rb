class SpamNotificationController < ApplicationController
  def create
    if params.dig("Type").eql?("SpamNotification")
      PostMessageToSlackService.call(email: spam_email)
      render json: {message: "Span notification successful"}, status: :created
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def spam_email
    params.dig("Email")
  end
end
