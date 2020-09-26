Rails.application.routes.draw do
  resources :orders do
    post :completed, on: :member
  end
  resources :line_items
  resources :carts
  get 'admin/index'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :restaurants do
    resources :comments
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
    post :receive_order, on: :member
    get :destroy_order_received, on: :member
    get :shipper, on: :member
    get :unshipper, on: :member # Need ID on url
    get :my_orders, on: :collection # Not need ID in url.
    get :orders_received, on: :collection
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
