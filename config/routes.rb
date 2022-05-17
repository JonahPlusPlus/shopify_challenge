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
      post "/checkout", to: "root#checkout"
      post "/additem", to: "inventory#additem"
    end
  end

  get "/inventory", to: "inventory#index"
  get "/backlog", to: "backlog#index"

  root to: "root#index"
end
