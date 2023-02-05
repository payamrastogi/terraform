resource "aws_s3_object" "layers" {
  bucket = var.s3_bucket_image_processing
  key    = "code/layers.zip"
  source = "${path.module}/../../layers/layers.zip"
  etag   = filemd5("${path.module}/../../layers/layers.zip")
}

resource "aws_lambda_layer_version" "layers" {
  s3_bucket        = var.s3_bucket_image_processing
  s3_key           = aws_s3_object.layers.key
  layer_name = "image_processing"
  compatible_runtimes = ["python3.8"]
}


# Zip of lambda code
data "archive_file" "lambda" {
  output_path = "${path.module}/../../lambdas/lambdas.zip"
  source_dir  = "${path.module}/../../lambdas"
  excludes    = ["__init__.py", "*.pyc"]
  type        = "zip"
}

resource "aws_s3_object" "lambda" {
  bucket = var.s3_bucket_image_processing
  key    = "code/lambdas.zip"
  source = data.archive_file.lambda.output_path
  etag   = filemd5(data.archive_file.lambda.output_path)
}

# Lambda function
resource "aws_lambda_function" "lambda_resize" {
  function_name    = var.lambda_resize
  s3_bucket        = var.s3_bucket_image_processing
  s3_key           = aws_s3_object.lambda.key
  source_code_hash = data.archive_file.lambda.output_base64sha256
  handler          = "resize.handler"
  role             = aws_iam_role.lambda_resize.arn
  runtime          = "python3.8"
  layers = [aws_lambda_layer_version.layers.arn]
  lifecycle {
    create_before_destroy = true
  }
}

## Lambda function
#resource "aws_lambda_function" "lambda_rotate" {
#  function_name    = var.lambda_rotate_name
#  s3_bucket        = var.s3_bucket_image_processing
#  s3_key           = aws_s3_object.lambda.key
#  filename         = data.archive_file.lambda.output_path
#  source_code_hash = data.archive_file.lambda.output_base64sha256
#  handler          = "rotate.handler"
#  role             = aws_iam_role.lambda_assume_role.arn
#  runtime          = "python3.8"
#
#  lifecycle {
#    create_before_destroy = true
#  }
#}
#
## Lambda function
#resource "aws_lambda_function" "lambda_filter" {
#  function_name    = var.lambda_filter_name
#  s3_bucket        = var.s3_bucket_image_processing
#  s3_key           = aws_s3_object.lambda.key
#  filename         = data.archive_file.lambda.output_path
#  source_code_hash = data.archive_file.lambda.output_base64sha256
#  handler          = "filter.handler"
#  role             = aws_iam_role.lambda_assume_role.arn
#  runtime          = "python3.8"
#
#  lifecycle {
#    create_before_destroy = true
#  }
#}
#
## Lambda function
#resource "aws_lambda_function" "lambda_convert" {
#  function_name    = var.lambda_convert_name
#  s3_bucket        = var.s3_bucket_image_processing
#  s3_key           = aws_s3_object.lambda.key
#  filename         = data.archive_file.lambda.output_path
#  source_code_hash = data.archive_file.lambda.output_base64sha256
#  handler          = "convert.handler"
#  role             = aws_iam_role.lambda_assume_role.arn
#  runtime          = "python3.8"
#
#  lifecycle {
#    create_before_destroy = true
#  }
#}
#
