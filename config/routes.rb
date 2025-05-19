Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  },
  defaults: { format: :json }

  get 'users/get_users', to: 'users/users#getUsers', as: :get_users

  resources :departments, only: [:index, :show, :create, :update, :destroy]
  
  resources :tickets do
  member do
    patch :close
    patch :resolve
    patch :reopen
    patch :assign
  end
    collection do
  get :all_tickets
end
end

  resources :articles, only: [:index, :show, :create, :update, :destroy]


  resources :notifications, only: [:index] do
    member do
      patch :mark_as_read
    end
  end
  
  get "up" => "rails/health#show", as: :rails_health_check


end
