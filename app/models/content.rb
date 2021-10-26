class Content < ApplicationRecord
  PRESIGNER = Aws::S3::Presigner.new
  enum product: [ :rpw, :sip ]

  def url
    return nil unless s3_key
    url, _ = PRESIGNER.presigned_request(
      :get_object,
      bucket: ENV["AWS_BUCKET_NAME"],
      expires_in: 60*60+60, # Expires in 1 hr + 1 min
      key: s3_key,
      use_accelerate_endpoint: true
    )
    url
  end
end
