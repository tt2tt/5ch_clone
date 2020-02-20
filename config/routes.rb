Rails.application.routes.draw do
  devise_for :users
  root to: 'top#top'
  get 'top/top'
  resources :categories, only: [:index]
  resources :boards, only: [:index, :create]
end
