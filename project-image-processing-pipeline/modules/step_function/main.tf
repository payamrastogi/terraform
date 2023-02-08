resource "aws_sfn_state_machine" "this" {
  name     = var.step_function_name
  role_arn = aws_iam_role.step_function.arn

  definition = <<EOF
  {
    "Comment": "Invoke AWS Lambda from AWS Step Functions with Terraform",
    "StartAt": "HelloWorld",
    "States": {
      "Resize Image": {
        "Type": "Task",
        "Resource": "${var.lambda_resize_arn}",
        "Next": "Rotate Image"
      },
      "Rotate Image": {
        "Type": "Task",
        "Resource": "${var.lambda_rotate_arn}",
        "Next": "Convert Image"
      },
      "Convert Image": {
        "Type": "Task",
        "Resource": "${var.lambda_convert_arn}",
        "Next": "Filter Image"
      },
      "Convert Image": {
        "Type": "Task",
        "Resource": "${var.lambda_filter_arn}",
        "End": true
      }
    }
  }
  EOF
}