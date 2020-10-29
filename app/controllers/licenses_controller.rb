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
    license_key = LicenseKey.find_by(key: params[:key])
    license_key.with_lock do
      return if license_key.email == params[:email].downcase || license_key.email_changed
      license_key.email_changed = true
      license_key.email = params[:email].downcase
      license_key.save
    end

    if license_key.changed? && !license_key.errors.any?
      EmailKeyRegistrationJob.perform_later(params[:key], params[:email])
      head :ok
    else
      head :forbidden
    end
  end

  def destroy
    LicenseKey.find_by(key: params[:key]).destroy!
    head :ok
  end
end
