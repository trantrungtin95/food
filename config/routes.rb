Rails.application.routes.draw do
  resources :line_items
  resources :carts
  get 'admin/index'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :restaurants do
    resources :dishes
  end
  resources :dishes

  get 'store/index'
  root :to => 'store#index'
  resources :users

  get 'admin' => 'admin#index'
  
    controller :sessions do
        get 'login' => :new
        post 'login' => :create
        delete 'logout' => :destroy
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
