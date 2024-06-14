class CreateMonthlyAverageStats < ActiveRecord::Migration[7.1]
  def change
    create_table :monthly_average_stats do |t|
      t.date :date
      t.string :subject
      t.string :monthly_avg_low
      t.string :monthly_avg_high
      t.integer :monthly_result_count_used
      t.timestamps
    end
  end
end
