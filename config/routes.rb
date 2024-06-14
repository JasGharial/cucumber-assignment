Rails.application.routes.draw do
  root 'home#index'
  get 'result_data', to: 'home#result_data'
  get 'daily_average_stat', to: 'home#daily_average_stat'
  get 'monthly_average_stat', to: 'home#monthly_average_stat'
  resources :results_data, only: %i[create]
  get 'up' => 'rails/health#show', as: :rails_health_check
end
