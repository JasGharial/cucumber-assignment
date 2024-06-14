# frozen_string_literal: true

Given('Today is {string}') do |date|
  @current_date = Time.parse(date).strftime('%Y-%m-%d %H:%M:%S')
end

And('we receive the following result data for subject {string}') do |subject, table|
  payload = table.hashes.to_a
  payload.each do |result_stat|
    ResultData.create(result_stat)
  end
end

Then("the system will calculate today's daily result stats for subject {string} as:") do |subject, table|
  GenerateResultStat::DailyStat.call(@current_date)
  daily_result_data = DailyResultStat.where(date: @current_date, subject: subject.capitalize)
                                     .pluck_to_hash(:date, :subject, :daily_low, :daily_high, :result_count)
  expected_data = table.hashes

  # This is convert the keys to string and the values to string for assertion
  # actual_data = [Hash[daily_result_data.keys.map(&:to_s).zip(daily_result_data.values.map(&:to_s))]]
  expect(daily_result_data).to eq(expected_data)
end
