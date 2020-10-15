Rails.application.routes.draw do
  resource :license, only: [:create, :show, :destroy]
  get "contents/positional", to: "contents#position"
  resources :contents, only: [:index, :show]
  post "new_purchase", to: "stripe_webhooks#create"
  post "/rpw-checkout" => "checkouts#create"
  post "/rpw-contact" => "contacts#create"
end
