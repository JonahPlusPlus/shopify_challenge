Rails.application.routes.draw do
  get 'backlog/index'
  get 'inventory/index'
  get 'root/index'
  namespace :api do
    namespace :v1 do
      resources :items
      resources :stores
      resources :orders
      resources :requests
    end
  end

  get "/inventory", to: "inventory#index"
  get "/backlog", to: "backlog#index"
  post "/api/v1/checkout", to: "root#checkout" # wish I could just put it in the namespace, but it also puts the controller in a namespace
  post "/api/v1/additem", to: "inventory#additem"

  root to: "root#index"
end
