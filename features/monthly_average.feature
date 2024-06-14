Feature:
  On a Monday of week of third Wednesday calculate the Monthly Averages by:
  - Going back atleast 5 days of Daily Result Stats data
  - If result count of these 5 days is less than 200, go back even more until the minimum aggregated result count of 200 is reached
  - Calculate Average of daily_high and daily_low along with the result_count considered

  Scenario: Calculate Monthly average if current date is
  Given Today is "2022-04-18"
  And the system has following Daily Result Stats:
    | date       | subject | daily_low | daily_high | result_count |
    | 2022-04-07 | Science | 119.88    | 126.76     | 18            |
    | 2022-04-08 | Science | 123.73    | 127.23     | 11            |
    | 2022-04-11 | Science | 121.12    | 124.52     | 12            |
    | 2022-04-12 | Science | 117.22    | 120.11     | 81            |
    | 2022-04-13 | Science | 118.84    | 119.29     | 22            |
    | 2022-04-14 | Science | 120.27    | 123.33     | 57            |
    | 2022-04-15 | Science | 126.01    | 128.77     | 23            |
    | 2022-04-18 | Science | 124.30    | 125.58     | 12            |

      # We should go backwards in days from today (18th) collecting result stats data for minimum 5 days (from 18th - 12th)
      # Sum of result_count from 18th to 12th = 195, which is less than our minimum requirement of 200.
      # We need to go back one day at a time and check if the minimum volume requirement is met.
      # Going back one more day (to 11th) seems to satisfy our minimum result_count requirement.
      # Our new range becomes: 18th to 11th: The new sum is 207 which satisfies our minimum result_count requirement

  When I calculate the Monthly Averages
  Then I should see the following monthly averages calculated:
  | date        | subject   | monthly_avg_low  | monthly_avg_high  | monthly_result_count_used  |
  | 2022-04-18  | Science   | 121.29           | 123.60            | 207                        |
