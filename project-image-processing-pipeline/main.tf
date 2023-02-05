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