# frozen_string_literal: true

And('the system has following Daily Result Stats:') do |table|
  payload = table.hashes.to_a
  DailyResultStat.create(payload)
end

When('I calculate the Monthly Averages') do
  GenerateResultStat::MonthlyStat.call(@current_date)
end

Then('I should see the following monthly averages calculated:') do |table|
  monthly_stat = MonthlyAverageStat.where(date: @current_date)
                                   .pluck_to_hash(:date, :subject, :monthly_avg_low, :monthly_avg_high, :monthly_result_count_used)
  expected_data = table.hashes
  expect(monthly_stat).to eq(expected_data)
end
