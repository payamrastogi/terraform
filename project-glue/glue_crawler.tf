resource "aws_glue_crawler" "example" {
  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
  name          = "s3_crawler"
  role          = aws_iam_role.aws_iam_glue_role.arn

  s3_target {
    path = "s3://${aws_s3_bucket.bucket_for_glue.bucket}/data/"
  }
}