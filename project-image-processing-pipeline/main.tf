module "api_gateway" {
  source = "./modules/api_gateway"
}

module "s3" {
  source = "./modules/s3"
}