Rails.application.routes.draw do
  resource :license, only: [:create, :show, :destroy]
  get "contents/positional", to: "contents#position"
  resources :contents, only: [:index, :show]
end
