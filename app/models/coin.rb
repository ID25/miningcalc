class Coin < ApplicationRecord
  has_many :cost_histories, dependent: :destroy
end
