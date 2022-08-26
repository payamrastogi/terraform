resource "aws_s3_bucket" "bucket_for_glue" {
  bucket = var.bucket_for_glue
  force_destroy = true
}

#Upload an object
resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.bucket_for_glue.id
  key    = "data/nginx_logs.txt"
  source = "data/nginx_logs.txt"
  etag = filemd5("data/nginx_logs.txt")
}