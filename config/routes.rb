Rails.application.routes.draw do
  root "static#index"

  resources :admins, only: [:index]

  get '/search', to: 'admins#search'
  post '/search', to: 'admins#foursquare'

  get '/gitsearch', to: 'admins#gitsearch'
  post '/github', to: 'admins#github'
end
