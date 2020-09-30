class LicensesController < ApplicationController 
  before_action :authenticate_user_api, only: :show

  def show 
    head :ok
  end

  def create

  end
end