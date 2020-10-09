class ContentsController < ApplicationController
  before_action :authenticate_user_api, only: :show

  def show
    @content = Content.find(params[:id])
    render json: @content.as_json(methods: :url)
  end

  def position
    @content = Content.where("position >= ?", params[:position]).order(:position).first
    render json: @content.as_json(methods: :url)
  end

  def index
    @contents = Content.order(:position)
    render json: @contents.as_json(methods: :url)
  end
end
