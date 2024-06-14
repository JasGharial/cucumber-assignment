Feature:
  For a given day, collect all the result data saved for a subject and calculate the daily stats with the following fields:
  - date:           The date for which the data is being aggregated
  - subject:        The subject we are aggregating the data for
  - daily_low:      The lowest marks seen in a day
  - daily_high:     The highest marks seen in a day
  - result_count:   The number of results received for the date

  Scenario: Create Daily Result Stats
    Given Today is "2022-04-18"
    And we receive the following result data for subject "Science"
      | subject | timestamp               | marks  |
      | Science | 2022-04-18 12:02:44.678 | 123.54 |
      | Science | 2022-04-18 13:37:26.678 | 120.99 |
      | Science | 2022-04-18 15:33:23.678 | 126.76 |
      | Science | 2022-04-18 17:21:55.678 | 119.88 |
      | Science | 2022-04-18 17:47:27.678 | 125.21 |
    Then the system will calculate today's daily result stats for subject "Science" as:
      | date        | subject   | daily_low  | daily_high  | result_count  |
      | 2022-04-18  | Science   | 119.88     | 126.76      | 5             |