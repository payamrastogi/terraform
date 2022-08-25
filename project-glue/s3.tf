resource "aws_s3_bucket" "athena-results" {
  bucket        = var.query_results_s3_bucket_name
  acl           = "private"
  force_destroy = true
}