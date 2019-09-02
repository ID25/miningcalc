class MiningController < ApplicationController
  def home; end

  def mining_profit_data
    render json: CoinCostsChart.call.chart_json
  end
end
