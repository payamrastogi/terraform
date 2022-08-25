# Output value definitions

output "lambda_bucket_name" {
  description = "Name of the S3 bucket used to store function code."
  value = aws_s3_bucket.s3-bucket-project-lamdba-20220824-01.id
}

output "function_name" {
  description = "Name of the Lambda function."
  value = aws_lambda_function.lambda-project-lambda-20220824-01.function_name
}