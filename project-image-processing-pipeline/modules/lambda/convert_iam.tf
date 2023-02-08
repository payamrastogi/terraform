# Resize Lambda IAM assume role
resource "aws_iam_role" "lambda_convert" {
  name               = var.lambda_convert
  #policy for who can assume this role
  assume_role_policy = data.aws_iam_policy_document.this.json

  lifecycle {
    create_before_destroy = true
  }
}

data aws_iam_policy_document "s3_rotated_read" {
  statement {
    actions = [
      "s3:HeadObject",
      "s3:GetObject",
      "s3:GetObjectAcl"
    ]
    resources = [
      "arn:aws:s3:::image-processing-20230204/rotated",
      "arn:aws:s3:::image-processing-20230204/rotated/*"
    ]
  }
}

resource aws_iam_policy "s3_rotated_read" {
  name        = "s3_rotated_read"
  description = "Permissions to read s3 resized bucket"
  policy      = data.aws_iam_policy_document.s3_rotated_read.json
}

resource aws_iam_role_policy_attachment "s3_rotated_read" {
  role       = aws_iam_role.lambda_convert.name
  policy_arn = aws_iam_policy.s3_rotated_read.arn
}

data aws_iam_policy_document "s3_converted_write" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    resources = [
      "arn:aws:s3:::image-processing-20230204/converted",
      "arn:aws:s3:::image-processing-20230204/converted/*"
    ]
  }
}

resource aws_iam_policy "s3_converted_write" {
  name        = "s3_converted_write"
  description = "Permissions to write s3 rotated bucket"
  policy      = data.aws_iam_policy_document.s3_converted_write.json
}

resource aws_iam_role_policy_attachment "s3_converted_write" {
  role       = aws_iam_role.lambda_convert.name
  policy_arn = aws_iam_policy.s3_converted_write.arn
}


