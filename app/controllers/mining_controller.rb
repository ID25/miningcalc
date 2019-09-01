class MiningController < ApplicationController
  def home
    @eth = CalcMiningProfit.new('ETH')
    @etc = CalcMiningProfit.new('ETC')
  end
end
