variable "s3_bucket_image_processing" {
  description = "Id of the S3 Bucket for this project"
  type        = string
}

# lambda function name
variable "lambda_resize" {
  description = "The name of the lambda function responsible for resizing the image"
  type = string
  default = "resize"
}

variable "lambda_rotate" {
  description = "The name of the lambda function responsible for rotating the image"
  type = string
  default = "rotate"
}

variable "lambda_convert" {
  description = "The name of the lambda function responsible for converting the image"
  type = string
  default = "convert"
}

variable "lambda_filter" {
  description = "The name of the lambda function to apply filter to the image"
  type = string
  default = "filter"
}

