# Lambda function
resource "aws_lambda_function" "lambda_function" {
  function_name    = var.lambda_function_name
  filename         = data.archive_file.lambda_zip_file.output_path
  source_code_hash = data.archive_file.lambda_zip_file.output_base64sha256
  handler          = "function.handler"
  role             = aws_iam_role.lambda_assume_role.arn
  runtime          = "python3.8"

  lifecycle {
    create_before_destroy = true
  }
}

# Zip of lambda handler
data "archive_file" "lambda_zip_file" {
  output_path = "${path.module}/lambdas/lambdas.zip"
  source_dir  = "${path.module}/lambdas"
  excludes    = ["__init__.py", "*.pyc"]
  type        = "zip"
}
