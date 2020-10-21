Rails.application.routes.draw do
  resources :line_items
  resources :carts do
    get :order_group, on: :collection
    post :group_code, on: :collection
  end
  get 'admin/index'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :restaurants do
    resources :orders do
      post :shippervote, on: :member
      post :uservote, on: :member
      post :completed, on: :member
      get :get_location_restaurants, on: :collection
      post :chat, on: :member
      get :chat_rooms, on: :collection
    end
    resources :comments
    resources :coupon_codes
    get :check_coupon_code, on: :collection
    get :destroy_coupon_code, on: :member
    get :search, on: :collection
    get :near_by, on: :collection
    post :resvote, on: :member
  end 
  resources :dishes do
    post :vote, on: :member
  end

  get 'store/index'
  root :to => 'store#index'
  resources :users do
    member do
      get :list_orders
      get :edit_email
      post :receive_order
      get :destroy_order_received
      get :shipper
      get :unshipper # Need ID on url
      get :orders_received
    end
    
    get :my_orders, on: :collection # Not need ID in url.
    get :shipper_location, on: :collection
    get :get_shipper_location, on: :collection
  end

  get 'admin' => 'admin#index'
  
    controller :sessions do
        get 'login' => :new
        post 'login' => :create
        delete 'logout' => :destroy
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
