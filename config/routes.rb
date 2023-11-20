Rails.application.routes.draw do
  root to: 'homes#index'
  get "users/profile" => "users#show"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :users
  
  resources :reservations do
    collection do
      post :confirm
    end
    member do
      patch 'edit_confirm'
    end
  end

  resources :rooms do
    get :search, on: :collection
  end  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
