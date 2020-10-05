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
end