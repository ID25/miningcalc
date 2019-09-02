class CalcMiningProfit
  attr_reader :coin, :coin_data

  def initialize(coin)
    @coin = coin.upcase
    @coin_data = CoinConsts.new(@coin)
  end

  def amount
    ((coin_data.h / hashrate) * coin_data.block_profit * coin_data.t * exchange_rate) / coin_data.block_time
  end

  def difficulty
    json = HTTParty.get(coin_data.api_endpoint)
    if coin == 'ETC'
      json['data']['difficulty'].to_f
    elsif coin == 'ETH'
      json['nodes'].first['difficulty'].to_f
    end
  end

  private

  def exchange_rate
    Cryptocompare::Price.find(coin, 'USDT')[coin]['USDT']
  end

  def hashrate
    difficulty / coin_data.block_time
  end
end
