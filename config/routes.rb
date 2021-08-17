Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :accounts, except: [ :update, :edit ] do
    resources :transactions do
    end
  end

  resources :goals do
    resources :goals_transactions do
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :goals
end
