# frozen_string_literal: true

ParameterType(
  name: 'request_type',
  regexp: /(?:valid|invalid)/,
  transformer: ->(type) { type.to_s }
)

ParameterType(
  name: 'request_status',
  regexp: /(?:resolved|rejected)/,
  transformer: ->(type) { type.to_s }
)
