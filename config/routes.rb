Rails.application.routes.draw do
  resources :orders
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
    get :shipper, on: :member
    get :unshipper, on: :member
    get :my_orders, on: :collection
  end

  get 'admin' => 'admin#index'
  
    controller :sessions do
        get 'login' => :new
        post 'login' => :create
        delete 'logout' => :destroy
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
