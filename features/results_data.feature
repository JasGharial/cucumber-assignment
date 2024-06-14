Feature: Create Result Data
  Whenever a student submits a test, a MSM would be sending the data to our application using
  webhook POST /results_data

  Scenario: Receiving valid webhook payload
    Given a webhook endpoint is configured
    When a POST request is received on webhook with valid payload
    Then the webhook payload should be resolved

  Scenario: Receiving invalid webhook payload
    Given a webhook endpoint is configured
    When a POST request is received on webhook with invalid payload
    Then the webhook payload should be rejected