class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods 

  def authenticate_user_api
    unless authenticate_with_http_basic { |u, _| LicenseKey.where(key: u).any? }
      render plain: "Your license key is incorrect.", status: :unauthorized
    end
  end
end
