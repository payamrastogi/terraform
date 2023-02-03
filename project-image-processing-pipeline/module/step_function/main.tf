resource "aws_sfn_state_machine" "this" {
  name     = var.step_function_name
  role_arn = aws_iam_role.step_function_role.arn

  definition = <<EOF
  {
    "Comment": "Invoke AWS Lambda from AWS Step Functions with Terraform",
    "StartAt": "HelloWorld",
    "States": {
      "HelloWorld": {
        "Type": "Task",
        "Resource": "${aws_lambda_function.lambda_function.arn}",
        "End": true
      }
    }
  }
  EOF
}