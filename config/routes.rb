Rails.application.routes.draw do
  resources :playlists, only: [:index, :show]
  get 'auth/spotify/callback', to: 'sessions#create'
  get 'signout', to: 'sessions#destroy', as: 'signout'
  root 'application#home'
end
