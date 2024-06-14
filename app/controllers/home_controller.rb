class HomeController < ApplicationController

  def index
    @result_data_count = ResultData.where('created_at BETWEEN ? AND ?', DateTime.current.beginning_of_day, DateTime.current.change(hour: 18)).count
    @daily_result_stat_count = DailyResultStat.count
    @monthly_average_stat_count = MonthlyAverageStat.count
  end

  def result_data
    @pagy, @results_data = pagy(ResultData.all)
    @results_data = @results_data.order(params[:sort]) if params[:sort].present?
  end

  def daily_average_stat
    @pagy, @daily_average_stat = pagy(DailyResultStat.all)
    @daily_average_stat = @daily_average_stat.order(params[:sort]) if params[:sort].present?
  end

  def monthly_average_stat
    @pagy, @monthly_average_stat = pagy(MonthlyAverageStat.all)
    @monthly_average_stat = @monthly_average_stat.order(params[:sort]) if params[:sort].present?
  end
end
