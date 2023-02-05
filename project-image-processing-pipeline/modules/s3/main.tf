# S3 Bucket uploads
resource "aws_s3_bucket" "image_processing" {
  # the name of the bucket
  bucket = var.s3_bucket_prefix
  # all object should be deleted from the bucket when the bucket is destroyed,
  # so that the bucket can be destroyed without error
  force_destroy = true
}

resource "aws_s3_bucket_acl" "image_processing" {
  bucket = aws_s3_bucket.image_processing.id
  acl    = "private"
}

#Test Object
resource "aws_s3_object" "test" {
  depends_on = [aws_s3_bucket.image_processing]
  bucket = var.s3_bucket_prefix
  key    = "uploads/image.png"
  source = "${path.module}/../../data/image.png"
  etag   = filemd5("${path.module}/../../data/image.png")
}

