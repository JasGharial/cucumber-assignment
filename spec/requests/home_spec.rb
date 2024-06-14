require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/home/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /result_data" do
    it "returns http success" do
      get "/home/result_data"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /daily_average_stat" do
    it "returns http success" do
      get "/home/daily_average_stat"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /monthly_average_stat" do
    it "returns http success" do
      get "/home/monthly_average_stat"
      expect(response).to have_http_status(:success)
    end
  end

end
