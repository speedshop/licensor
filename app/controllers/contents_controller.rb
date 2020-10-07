class ContentsController < ApplicationController
  before_action :authenticate_user_api, only: :show

  def show
    # Created signed url 
    # Return signed url 
  end

  def index
    @contents = Content.order(:position)
    render json: @contents
  end
end
