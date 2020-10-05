Rails.application.routes.draw do
  resource :license, only: [:create, :show, :destroy]
  resources :contents, only: [:index, :show]
end
