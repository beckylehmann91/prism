module AwsHelper
  def create_s3
    s3 = Aws::S3.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
  end

  def bucket_name
    return ENV["AWS_BUCKET_NAME"]
  end

  def file_path_destroy(post)
    post.first.images.first.filename.path
  end
end
