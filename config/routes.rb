Rails.application.routes.draw do
  root to: 'home#index', as: :user_root
  devise_for :users, path: :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :home, only: %i[new create edit update] do
    put :update_call_log, on: :member
  end
  scope controller: :home do
    post :add_call_log
  end
  resources :applicants, except: :show
  resources :batches, except: :show
end
