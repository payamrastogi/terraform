resource "aws_s3_bucket" "bucket_for_glue" {
  # the name of the bucket
  bucket = var.bucket_for_glue
  # all object should be deleted from the bucket when the bucket is destroyed,
  # so that the bucket can be destroyed without error
  force_destroy = true
}

#Upload an object
resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.bucket_for_glue.id
  key    = "data/nginx_logs.txt"
  source = "data/nginx_logs.txt"
  etag = filemd5("data/nginx_logs.txt")
}