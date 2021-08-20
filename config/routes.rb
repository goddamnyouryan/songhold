Rails.application.routes.draw do
  get 'auth/spotify/callback', to: 'sessions#create'
  get 'signout', to: 'sessions#destroy', as: 'signout'
  root 'application#root'
end
