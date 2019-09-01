class MiningController < ApplicationController
  def home; end

  def mining_profit_data
    @eth = CalcMiningProfit.new('ETH')
    @etc = CalcMiningProfit.new('ETC')
    render json: [@etc.chart_data, @eth.chart_data].chart_json
  end
end
