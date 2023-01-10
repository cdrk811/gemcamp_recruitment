Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'home#index', as: :user_root
  devise_for :users, path: :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
end
