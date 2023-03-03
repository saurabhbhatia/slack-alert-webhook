class SpamNotificationController < ApplicationController
  def create
    if params.dig("Type").eql?("SpamNotification")
      client = Slack::Web::Client.new
      client.chat_postMessage(channel: '#spam-notifications', text: "Spam Email: #{spam_email}", as_user: true)
      render json: {message: "success"}, status: :created
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def spam_email
    params.dig("Email")
  end
end
