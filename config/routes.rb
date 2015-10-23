Rails.application.routes.draw do
  root 'subscriptions#new'

  resources :events
  resources :subscriptions

end
