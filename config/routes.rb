Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get "/dashboard", to: "users#dashboard", as: "dashboard"
    
  resources :accounts, except: [ :update, :edit ] do
    resources :transactions, only: [ :create, :delete, :index ]
  end

  resources :goals do
    resources :goals_transactions, only: [ :create, :delete, :index ]
  end
end
