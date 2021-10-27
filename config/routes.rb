Rails.application.routes.draw do
  resource :license, only: [:create, :show, :destroy, :update]
  resources :contents, only: [:index]
  post "stripe_webhooks", to: "stripe_webhooks#create"
  post "rpw-checkout" => "checkouts#create"
  post "rpw-contact" => "contacts#create"
  post "gumroad-hook" => "gumroad_webhooks#create"
end
