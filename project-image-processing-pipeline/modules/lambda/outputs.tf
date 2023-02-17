output "lambda_resize_arn" {
  value = aws_lambda_function.lambda_resize.arn
}

output "lambda_rotate_arn" {
  value = aws_lambda_function.lambda_rotate.arn
}

output "lambda_convert_arn" {
  value = aws_lambda_function.lambda_convert.arn
}

output "lambda_filter_arn" {
  value = aws_lambda_function.lambda_filter.arn
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