# Lambda IAM assume role
resource "aws_iam_role" "lambda_assume_role" {
  name               = "${var.lambda_function_name}-assume-role"
  #policy for who can assume this role
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy_document.json

  lifecycle {
    create_before_destroy = true
  }
}

# IAM policy document for lambda assume role
data "aws_iam_policy_document" "lambda_assume_role_policy_document" {
  version = "2012-10-17"

  statement {
    sid     = "LambdaAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}
