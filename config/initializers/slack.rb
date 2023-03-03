Slack.configure do |config|
  config.token = Rails.application.credentials.slack_bot_user_oauth_token
end