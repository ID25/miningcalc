class CalcMiningProfit
  API_ENDPOINT = 'https://eth.ezil.me/api/'

  attr_reader :coin

  def initialize(coin)
    @coin = coin
  end

  def self.difficulty
    HTTParty.get("#{API_ENDPOINT}/stats")['nodes'].first['difficulty']
  end

  def exchange_rate
    Cryptocompare::Price.find(coin, 'USDT')[coin]['USDT']
  end
end
