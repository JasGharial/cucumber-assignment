# frozen_string_literal: true

# This controller is for facilitating Webhook integration for receiving daily_result_stat from MSN
class ResultsDataController < ApplicationController
  def create
    result_data = ResultData.new(result_data_params)
    if result_data.valid?
      result_data.save!
      render json: { data: result_data, message: 'Result Data created successfully', success: true }, status: 200
    else
      render json: { data: {}, message: 'Please check your parameters and try again', success: false }, status: 400
    end
  end

  private

  def result_data_params
    params.permit(:subject, :timestamp, :marks)
  end
end
