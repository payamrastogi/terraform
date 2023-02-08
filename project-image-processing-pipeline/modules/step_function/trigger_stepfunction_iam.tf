data "aws_iam_policy_document" "this" {
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

# Resize Lambda IAM assume role
resource "aws_iam_role" "lambda_trigger_step_function" {
  name               = var.lambda_trigger_step_function
  #policy for who can assume this role
  assume_role_policy = data.aws_iam_policy_document.this.json

  lifecycle {
    create_before_destroy = true
  }
}

data aws_iam_policy_document "lambda_trigger_step_function" {
  statement {
    actions = [
      "states:StartExecution"
    ]
    resources = [
      aws_sfn_state_machine.this.arn
    ]
  }
}

resource aws_iam_policy "lambda_trigger_step_function" {
  name        = "lambda_trigger_step_function"
  description = "Permissions to write s3 resized bucket"
  policy      = data.aws_iam_policy_document.lambda_trigger_step_function.json
}

resource aws_iam_role_policy_attachment "lambda_trigger_step_function" {
  role       = aws_iam_role.lambda_trigger_step_function.name
  policy_arn = aws_iam_policy.lambda_trigger_step_function.arn
}