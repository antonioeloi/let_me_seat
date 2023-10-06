Rails.application.routes.draw do
  put 'cart', to: 'cart#reserve', as: 'reserve'
  resources :seats
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "seats#index"
end
