# Lambda function
resource "aws_lambda_function" "lambda_trigger_step_function" {
  function_name    = var.lambda_trigger_step_function
  s3_bucket        = var.s3_bucket_image_processing
  s3_key           = var.s3_object_lambda_key
  source_code_hash = var.lambda_source_code_hash
  handler          = "trigger_step_function.handler"
  role             = aws_iam_role.lambda_trigger_step_function.arn
  runtime          = "python3.8"
  layers = [var.lambda_layer_version_arn]
  lifecycle {
    create_before_destroy = true
  }
}