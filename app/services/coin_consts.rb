class CoinConsts
  CONSTS = {
    'ETH' => {
      block_profit: 2.00,
      average_block_time: 13.48,
      api_endpoint: 'https://eth.ezil.me/api/stats'
    },
    'ETC' => {
      block_profit: 3.79,
      average_block_time: 13.95,
      api_endpoint: 'https://api-etc.ethermine.org/networkStats'
    }
  }.freeze

  attr_reader :coin

  def initialize(coin)
    @coin = coin
  end

  def block_profit
    CONSTS[coin][:block_profit]
  end

  def block_time
    CONSTS[coin][:average_block_time]
  end

  def api_endpoint
    CONSTS[coin][:api_endpoint]
  end

  def h
    10**9
  end

  def t
    1.minute
  end
end
