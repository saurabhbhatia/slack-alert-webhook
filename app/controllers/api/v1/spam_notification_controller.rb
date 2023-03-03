# frozen_string_literal: true

module Api
  module V1
    class SpamNotificationController < ApplicationController
      def create
        if spam_notification
          PostMessageToSlackService.call(email: spam_email)
          render json: { message: 'Span notification successful' }, status: :created
        else
          render json: {}, status: :unprocessable_entity
        end
      end

      def spam_email
        params['Email']
      end

      def spam_notification
        params['Type'].eql?('SpamNotification')
      end
    end
  end
end
