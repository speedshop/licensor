class GumroadWebhooksController < ApplicationController
  before_action :authenticate_admin_api

  def create
    email = params["email"]
    product = params["product"]
    key = params["key"]

    LicenseKey.create!(
      email: email.downcase,
      product: product,
      key: key
    )
  end
end