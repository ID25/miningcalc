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
    current_time = DateTime.now.beginning_of_day
    profit = calc_profit.round(2)
    per_hour = profit / 24.0
    data = 0.upto(21).each_with_object({}) do |_i, obj|
      current_time += 1.hour
      obj[current_time] = per_hour.round(2)
      obj
    end.merge({ current_time.beginning_of_day => per_hour, current_time.end_of_day => profit })
    { name: coin, data: data }
  end
end
