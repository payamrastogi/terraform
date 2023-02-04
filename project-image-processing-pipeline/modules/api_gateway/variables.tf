# api gateway rest api name
variable "upload_api" {
  description = "The name of the API Gateway rest api"
  type = string
  default = "upload"
}

#AWS region
variable "aws_region" {
  description = "AWS Region"
  type = string
  default = "us-east-1"
}