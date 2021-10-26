class ContentsController < ApplicationController
  def setup

  end

  def index
    @contents = Content.order(:position)
    if authenticate_with_http_basic { |u, _| LicenseKey.where(key: u).any? }
      render json: @contents.as_json(methods: :url)
    else
      render json: @contents.as_json
    end
  end
end
