Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }

  authenticated :user do
    if -> { admin_user? }
      get 'admin', to: 'admin#index', as: :admin_root
    else
      root to: 'products#index', as: :user_root
    end
  end
  root 'products#index', only: %i[index show search]

  namespace :admin do
    resources :categories
    resources :products do
      resources :images, only: :destroy
      resources :stocks
    end
    resources :orders do
      patch 'mark_fulfilled', on: :member, to: 'orders#mark_fulfilled'
      patch 'mark_unfulfilled', on: :member, to: 'orders#mark_unfulfilled'
    end
  end
  resources :products, only: %i[index show] do
    get :search, on: :collection
  end

  resources :categories, only: %i[show]
  
  authenticated :user do    
    get 'carts/:id', to: 'carts#show', as: 'carts'
    post 'buy_now/:product_id', to: 'cart_items#buy_now', as: 'buy_now'
    post 'add_to_cart/:product_id', to: 'cart_items#add_to_cart', as: 'add_to_cart'
    delete 'remove_from_cart/:product_id', to: 'cart_items#remove_from_cart', as: 'remove_from_cart'
  
    post 'add_quantity/:product_id', to: 'cart_items#add_quantity', as: 'cart_item_add_quantity'
    post 'sub_quantity/:product_id', to: 'cart_items#sub_quantity', as: 'cart_item_sub_quantity'
    
    post 'orders', to: 'orders#order', as: 'new_order'
    get 'success', to: 'orders#success', as: 'success'
    get 'orders', to: 'orders#index', as: 'orders'
    get 'orders/:order_id', to: 'orders#show', as: 'order_show'
    delete 'orders/:order_id', to: 'orders#destroy', as: 'order_destroy'
  
    get 'order_address', to: 'orders#new_order_address', as: 'new_order_address'
  end
  

  # get 'search', to: 'products#search', as: 'search'

  # patch 'orders/:id/mark_fulfilled', to: 'orders#mark_fulfilled', as: 'mark_fulfilled_order'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
