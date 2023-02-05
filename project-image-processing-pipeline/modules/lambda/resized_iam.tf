# Resize Lambda IAM assume role
resource "aws_iam_role" "lambda_resize" {
  name               = "${var.lambda_resize}"
  #policy for who can assume this role
  assume_role_policy = data.aws_iam_policy_document.this.json

  lifecycle {
    create_before_destroy = true
  }
}

data aws_iam_policy_document "uploads_read" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl"
    ]
    resources = [
      "arn:aws:s3:::image_processing/uploads"
    ]
  }
}

data aws_iam_policy_document "s3_resized_write" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    resources = [
      "arn:aws:s3:::image_processing/resized"
    ]
  }
}

resource aws_iam_policy "s3_uploads_read" {
  name        = "s3_uploads_bucket_read_policy"
  description = "Permissions to read s3 uploads bucket"
  policy      = data.aws_iam_policy_document.resized_write.json
}

resource aws_iam_policy "s3_resized_write" {
  name        = "s3_resized_bucket_write_policy"
  description = "Permissions to write s3 resized bucket"
  policy      = data.aws_iam_policy_document.resized_write.json
}


resource aws_iam_role_policy_attachment "resize" {
  for_each = toset([
    aws_iam_policy.s3_uploads_read.arn,
    aws_iam_policy.s3_resized_write.arn
  ])

  role       = aws_iam_role.resize.name
  policy_arn = each.value
}

