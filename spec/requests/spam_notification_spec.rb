# frozen_string_literal: true

require 'rails_helper'

describe 'post a spam notification to slack', type: :request do
  let(:payload) do
    {
      "RecordType": 'Bounce',
      "Type": 'SpamNotification',
      "TypeCode": 512,
      "Name": 'Spam notification',
      "Tag": '',
      "MessageStream": 'outbound',
      "Description": 'The message was delivered, but was either blocked by the user, or classified as spam, bulk mail, or had rejected content.',
      "Email": 'zaphod@example.com',
      "From": 'notifications@honeybadger.io',
      "BouncedAt": '2023-02-27T21:41:30Z'
    }
  end
  before do
    post '/api/v1/spam_notification', params: payload
  end

  it 'returns the a success message once slack message is posted' do
    expect(JSON.parse(response.body)['message']).to eq('Span notification successful')
  end

  it 'returns a created status' do
    expect(response).to have_http_status(:created)
  end
end
