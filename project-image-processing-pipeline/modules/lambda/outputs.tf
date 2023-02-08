output "lambda_resize_arn" {
  value = aws_lambda_function.lambda_resize
}

output "lambda_rotate_arn" {
  value = aws_lambda_function.lambda_rotate
}

output "lambda_convert_arn" {
  value = aws_lambda_function.lambda_convert
}

output "lambda_filter_arn" {
  value = aws_lambda_function.lambda_filter
}

output "lambda_trigger_step_function_arn" {
  value = aws_lambda_function.lambda_resize
}

output "s3_object_lambda_key" {
  value = aws_s3_object.lambda.key
}

output "lambda_source_code_hash" {
   value = data.archive_file.lambda.output_base64sha256
}

output "lambda_layer_version_arn" {
    value = aws_lambda_layer_version.layers.arn
}