Rails.application.routes.draw do
  root to: 'top#top'
  get 'top/top'
  resources :categories, only: [:index]
end
