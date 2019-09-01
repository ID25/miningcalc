class MiningController < ApplicationController
  def home
    @eth_data = CalcMiningProfit.new('ETH')
    @etc_data = CalcMiningProfit.new('ETC')
    @difficulty = CalcMiningProfit.difficulty
    @coin = CoinConsts.new('ETC')
  end
end
