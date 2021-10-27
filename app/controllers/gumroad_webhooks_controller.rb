class GumroadWebhooksController < ApplicationController
  before_action :authenticate_admin_api

  def create
    email = params["email"]
    product = params["product"]

    LicenseKey.create!(
      email: email.downcase,
      product: product,
      key: LicenseKey.generate_key
    )
  end
end