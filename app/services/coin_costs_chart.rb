class CoinCostsChart
  def self.call
    new.chart_data
  end

  def chart_data
    Coin.includes(:cost_histories).group(:name).map do |coin|
      add_amount_history(coin)
      { name: coin.name.upcase, data: coin_amount_history(coin.cost_histories) }
    end
  end

  private

  def coin_amount_history(histories)
    histories.group_by_minute(:created_at).map do |history|
      [history.created_at, history.amount]
    end.to_h
  end

  def add_amount_history(coin)
    coin_data = CalcMiningProfit.new(coin.name)
    coin.cost_histories.find_or_create_by(amount: coin_data.amount, difficulty: coin_data.difficulty)
  end
end
