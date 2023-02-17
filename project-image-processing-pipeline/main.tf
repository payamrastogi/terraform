module "api_gateway" {
  source = "./modules/api_gateway"
}

module "s3" {
  source = "./modules/s3"
}

module "lambda" {
  source = "./modules/lambda"
  s3_bucket_image_processing = module.s3.s3_bucket_image_processing
}

module "step_function" {
  depends_on = [module.lambda]
  source  = "./modules/step_function"
  lambda_resize_arn = module.lambda.lambda_resize_arn
  lambda_rotate_arn = module.lambda.lambda_rotate_arn
  lambda_convert_arn = module.lambda.lambda_convert_arn
  lambda_filter_arn = module.lambda.lambda_filter_arn
  lambda_layer_version_arn = module.lambda.lambda_layer_version_arn
  lambda_source_code_hash = module.lambda.lambda_source_code_hash
  s3_object_lambda_key = module.lambda.s3_object_lambda_key
  s3_bucket_image_processing = module.s3.s3_bucket_image_processing
}

module "sns" {
  source = "./modules/sns"
}