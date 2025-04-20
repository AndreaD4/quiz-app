Rails.application.routes.draw do
  devise_for :players
  devise_for :managers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'backup' => 'static#backup', as: :backup

  namespace :manager, module: 'managers' do
    resource :company, only: [:edit, :update] do
      get :backup, on: :collection
      get :poweroff, on: :collection
    end

    resources :notices do
      get :toggle_seen, on: :member
      post :toggle_seen, on: :member
      post :modal_notices, on: :collection
    end

    resources :reports

    root 'static#home'
  end

  root to: 'managers/static#home'
  # root to: 'players#dashboard'
end
