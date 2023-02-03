# lambda function name
variable "lambda_function_name" {
  description = "The name of the lambda function."
  type = string
  default = "image_resizing"
}