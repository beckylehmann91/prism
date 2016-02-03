module AwsHelper
  def create_s3
    AWS::S3.new(access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
  end

  def file_key(post)
    post.images.first.filename.path
  end

  def bucket_name
    return ENV['AWS_BUCKET_NAME']
  end
end