class CalcMiningProfit
  API_ENDPOINT = 'https://eth.ezil.me/api/'

  attr_reader :coin, :coin_data

  def initialize(coin)
    @coin = coin
    @coin_data = CoinConsts.new(coin)
  end

  def self.difficulty
    HTTParty.get("#{API_ENDPOINT}/stats")['nodes'].first['difficulty'].to_f
  end

  def exchange_rate
    Cryptocompare::Price.find(coin, 'USDT')[coin]['USDT']
  end

  def calc_profit
    ((coin_data.h / hashrate) * coin_data.block_profit * coin_data.t * exchange_rate) / coin_data.block_time
  end

  def hashrate
    self.class.difficulty / coin_data.block_time
  end
end
