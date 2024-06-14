# frozen_string_literal: true

Given('a webhook endpoint is configured') do
  Rails.application.routes.draw do
    resources :results_data, only: %i[create]
  end
end

When('a POST request is received on webhook with {request_type} payload') do |request|
  case request
  when 'valid'
    @request = post '/results_data',
                    params: { subject: 'Science', timestamp: DateTime.current, marks: rand(Math::E..100.00) }
  when 'invalid'
    @request = post '/results_data',
                    params: { subject: 'Science', marks: rand(Math::E..100.00) }
  end
end

Then('the webhook payload should be {request_status}') do |status|
  case status
  when 'processed'
    assert_equal 200, @request.status
  when 'rejected'
    assert_equal 400, @request.status
  end
end
