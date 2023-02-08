# IAM policy document for lambda assume role
data "aws_iam_policy_document" "step_function" {
  version = "2012-10-17"

  statement {
    sid     = "StepFunctionAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["states.amazonaws.com"]
      type        = "Service"
    }
  }
}

# Step Function IAM assume role
resource "aws_iam_role" "step_function" {
  name               = "step_function"
  #policy for who can assume this role
  assume_role_policy = data.aws_iam_policy_document.step_function.json

  lifecycle {
    create_before_destroy = true
  }
}

# policy for step functions
data aws_iam_policy_document "lambda_invocation_role" {
  statement {
    actions = [
      "lambda:InvokeFunction"
    ]
    resources = [
      var.lambda_resize_arn,
      var.lambda_rotate_arn,
      var.lambda_convert_arn,
      var.lambda_filter_arn
    ]
  }
}

# allow step functions to invoke lambda
resource aws_iam_policy "lambda_invocation_role" {
  name = "step_function"
  description = "Permissions to Invoke lambdas"
  policy      = data.aws_iam_policy_document.lambda_invocation_role.json
}

resource aws_iam_role_policy_attachment "step_function" {
  role       = aws_iam_role.step_function.name
  policy_arn = aws_iam_policy.lambda_invocation_role.arn
}

