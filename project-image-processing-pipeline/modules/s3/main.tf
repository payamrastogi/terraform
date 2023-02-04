# S3 Bucket uploads
resource "aws_s3_bucket" "uploads" {
  # the name of the bucket
  bucket = var.s3_bucket_prefix
  # all object should be deleted from the bucket when the bucket is destroyed,
  # so that the bucket can be destroyed without error
  force_destroy = true
  key = "${var.s3_bucket_uploads}/"
}

resource "aws_s3_bucket_acl" "uploads" {
  bucket = aws_s3_bucket.uploads.id
  acl    = "private"
}

# S3 Bucket resized
resource "aws_s3_bucket" "resized" {
  bucket = var.s3_bucket_prefix
  force_destroy = true
  key = "${var.s3_bucket_resized}/"
}

resource "aws_s3_bucket_acl" "resized" {
  bucket = aws_s3_bucket.resized.id
  acl    = "private"
}


# S3 Bucket rotated
resource "aws_s3_bucket" "rotated" {
  bucket = var.s3_bucket_prefix
  force_destroy = true
  key = "${var.s3_bucket_rotated}/"
}

resource "aws_s3_bucket_acl" "rotated" {
  bucket = aws_s3_bucket.rotated.id
  acl    = "private"
}

# S3 Bucket converted
resource "aws_s3_bucket" "converted" {
  bucket = var.s3_bucket_prefix
  force_destroy = true
  key = "${var.s3_bucket_converted}/"
}

resource "aws_s3_bucket_acl" "converted" {
  bucket = aws_s3_bucket.converted.id
  acl    = "private"
}


# S3 Bucket filtered
resource "aws_s3_bucket" "filtered" {
  bucket = var.s3_bucket_prefix
  force_destroy = true
  key = "${var.s3_bucket_filtered}/"
}

resource "aws_s3_bucket_acl" "filtered" {
  bucket = aws_s3_bucket.filtered.id
  acl    = "private"
}

# S3 Bucket output
resource "aws_s3_bucket" "output" {
  bucket = var.s3_bucket_prefix
  force_destroy = true
  key = "${var.s3_bucket_output}/"
}

resource "aws_s3_bucket_acl" "output" {
  bucket = aws_s3_bucket.output.id
  acl    = "private"
}
