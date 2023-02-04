# Lambda function
resource "aws_lambda_function" "lambda_resize" {
  function_name    = var.lambda_resize_name
  filename         = data.archive_file.lambda_zip_file.output_path
  source_code_hash = data.archive_file.lambda_zip_file.output_base64sha256
  handler          = "resize.handler"
  role             = aws_iam_role.lambda_assume_role.arn
  runtime          = "python3.8"

  lifecycle {
    create_before_destroy = true
  }
}

# Lambda function
resource "aws_lambda_function" "lambda_rotate" {
  function_name    = var.lambda_rotate_name
  filename         = data.archive_file.lambda_zip_file.output_path
  source_code_hash = data.archive_file.lambda_zip_file.output_base64sha256
  handler          = "rotate.handler"
  role             = aws_iam_role.lambda_assume_role.arn
  runtime          = "python3.8"

  lifecycle {
    create_before_destroy = true
  }
}

# Lambda function
resource "aws_lambda_function" "lambda_filter" {
  function_name    = var.lambda_filter_name
  filename         = data.archive_file.lambda_zip_file.output_path
  source_code_hash = data.archive_file.lambda_zip_file.output_base64sha256
  handler          = "filter.handler"
  role             = aws_iam_role.lambda_assume_role.arn
  runtime          = "python3.8"

  lifecycle {
    create_before_destroy = true
  }
}

# Lambda function
resource "aws_lambda_function" "lambda_convert" {
  function_name    = var.lambda_convert_name
  filename         = data.archive_file.lambda_zip_file.output_path
  source_code_hash = data.archive_file.lambda_zip_file.output_base64sha256
  handler          = "convert.handler"
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