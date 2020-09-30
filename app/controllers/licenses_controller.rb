class LicensesController < ApplicationController 
  before_action :authenticate_user_api, only: :show
  before_action :authenticate_admin_api, only: :create

  def show 
    head :ok
  end

  def create
    LicenseKey.create!(key: params[:key])
    head :ok
  end

  private

  def authenticate_admin_api
    unless authenticate_with_http_basic { |u, _| u == ENV["ADMIN_API_KEY"] }
      render plain: "Your license key is incorrect.", status: :unauthorized
    end
  end
end