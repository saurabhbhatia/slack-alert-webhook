Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'spam_notification', to: 'spam_notification#create'
    end
  end
end
