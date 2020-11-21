class Content < ApplicationRecord
  def url
    return nil unless s3_key
    signer = Aws::S3::Presigner.new
    url, _ = signer.presigned_request(
      :get_object,
      bucket: ENV["AWS_BUCKET_NAME"],
      expires_in: 60*60+60, # Expires in 1 hr + 1 min
      key: s3_key,
      use_accelerate_endpoint: true
    )
    url
  end
end
