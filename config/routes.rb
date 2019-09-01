Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'mining#home'

  get :mining_profit_data, to: 'mining#mining_profit_data'
end
