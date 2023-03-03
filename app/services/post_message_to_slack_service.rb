# frozen_string_literal: true

class PostMessageToSlackService
  def self.call(email:)
    new(email).call
  end

  def initialize(email)
    @email = email
  end

  def call
    client = Slack::Web::Client.new
    client.chat_postMessage(channel: '#spam-notifications', text: "Spam Email: #{@email}", as_user: true)
  end
end
