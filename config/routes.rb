Rails.application.routes.draw do
  post 'spam_notification', to: 'spam_notification#create'
end
