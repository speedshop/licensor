Rails.application.routes.draw do
  resource :license, only: [:create, :show]
  resources :contents, only: [:index, :show]
end
