# Resize Lambda IAM assume role
resource "aws_iam_role" "lambda_filter" {
  name               = var.lambda_filter
  #policy for who can assume this role
  assume_role_policy = data.aws_iam_policy_document.this.json

  lifecycle {
    create_before_destroy = true
  }
}

data aws_iam_policy_document "s3_converted_read" {
  statement {
    actions = [
      "s3:HeadObject",
      "s3:GetObject",
      "s3:GetObjectAcl"
    ]
    resources = [
      "arn:aws:s3:::image-processing-20230204/converted",
      "arn:aws:s3:::image-processing-20230204/converted/*"
    ]
  }
}

resource aws_iam_policy "s3_converted_read" {
  name        = "s3_resized_bucket_read_policy"
  description = "Permissions to read s3 resized bucket"
  policy      = data.aws_iam_policy_document.s3_converted_read.json
}

resource aws_iam_role_policy_attachment "s3_converted_read" {
  role       = aws_iam_role.lambda_filter.name
  policy_arn = aws_iam_policy.s3_converted_read.arn
}

data aws_iam_policy_document "s3_filtered_write" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    resources = [
      "arn:aws:s3:::image-processing-20230204/filtered",
      "arn:aws:s3:::image-processing-20230204/filtered/*"
    ]
  }
}

resource aws_iam_policy "s3_filtered_write" {
  name        = "s3_rotated_bucket_write_policy"
  description = "Permissions to write s3 resized bucket"
  policy      = data.aws_iam_policy_document.s3_rotated_write.json
}

resource aws_iam_role_policy_attachment "s3_filtered_write" {
  role       = aws_iam_role.lambda_filter.name
  policy_arn = aws_iam_policy.s3_filtered_write.arn
}


