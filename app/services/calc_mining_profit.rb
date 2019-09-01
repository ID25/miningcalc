class CalcMiningProfit
  API_ENDPOINT = 'https://eth.ezil.me/api/'.freeze

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

  def chart_data
    current_time = DateTime.now
    data = { current_time.beginning_of_day => 0.0, current_time.end_of_day => calc_profit.round(2) }
    { name: coin, data: data }
  end
end
