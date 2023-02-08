# step function invocation lambda
variable "lambda_trigger_step_function" {
  description = "The name of the lambda function responsible for triggering step function"
  type = string
  default = "trigger_step_function"
}

variable "s3_bucket_image_processing" {
  description = "Id of the S3 Bucket for this project"
  type        = string
}

variable "s3_object_lambda_key" {
    description = "S3 Object key"
    type = string
}

variable "lambda_source_code_hash" {
    description = "lambda source code hash"
    type = string
}

variable "lambda_layer_version_arn" {
    description = "lambda layer version arn"
    type = string
}

variable "step_function_name" {
    description = "The name of the step function."
    type = string
    default = "image_processing"
}

variable "lambda_resize_arn" {
    description = "Resize lambda arn"
    type = string
}

variable "lambda_rotate_arn" {
    description = "Rotate lambda arn"
    type = string
}

variable "lambda_convert_arn" {
    description = "Convert lambda arn"
    type = string
}

variable "lambda_filter_arn" {
    description = "Filter lambda arn"
    type = string
}