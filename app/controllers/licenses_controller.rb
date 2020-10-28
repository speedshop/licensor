class LicensesController < ApplicationController
  before_action :authenticate_user_api, only: :show
  before_action :authenticate_admin_api, only: [:create, :destroy]

  def show
    head :ok
  end

  def create
    LicenseKey.create!(key: params[:key])
    head :ok
  end

  def update
    EmailKeyRegistrationJob.perform_later(params[:key], params[:email])
    head :ok
  end

  def destroy
    LicenseKey.find_by(key: params[:key]).destroy!
    head :ok
  end
end
