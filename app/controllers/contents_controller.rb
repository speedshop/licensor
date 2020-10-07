class ContentsController < ApplicationController
  before_action :authenticate_user_api, only: :show

  def show
    @content = Content.find(params[:id])
    signer = Aws::S3::Presigner.new
    url, headers = signer.presigned_request(
      :get_object, 
      bucket: ENV["AWS_BUCKET_NAME"], 
      key: @content.s3_key, 
      use_accelerate_endpoint: true
    )
    render json: { url: url }
  end

  def index
    @contents = Content.order(:position)
    render json: @contents
  end
end
