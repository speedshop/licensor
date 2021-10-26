class ContentsController < ApplicationController
  def index
    product = params[:product] || "rpw"

    key, password = ActionController::HttpAuthentication::Basic.user_name_and_password(request)
    license = LicenseKey.find_by(key: key)
    product = license.product if license

    @contents = Content.order(:position).where(product: product)
    if license
      render json: @contents.as_json(methods: :url)
    else
      render json: @contents.as_json
    end
  end
end
