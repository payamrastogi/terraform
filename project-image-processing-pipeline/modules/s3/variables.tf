# s3 bucket prefix
# only alphanumeric characters, hyphens, periods, and underscores allowed
variable "s3_bucket_prefix" {
  description = "prefix for all the buckets"
  type = string
  default = "image-processing-20230204"
}

# s3 bucket upload
variable "s3_bucket_uploads" {
  description = "The name of the bucket to upload the images."
  type = string
  default = "uploads"
}

# s3 bucket resized
variable "s3_bucket_resized" {
  description = "The name of the bucket to store the resized images"
  type = string
  default = "resized"
}

# s3 bucket rotated
variable "s3_bucket_rotated" {
  description = "The name of the bucket to store the rotated images"
  type = string
  default = "rotated"
}

# s3 bucket converted
variable "s3_bucket_converted" {
  description = "The name of the bucket to store the converted images"
  type = string
  default = "converted"
}

# s3 bucket filtered
variable "s3_bucket_filtered" {
  description = "The name of the bucket to store the filtered images"
  type = string
  default = "filtered"
}

# s3 bucket output
variable "s3_bucket_output" {
  description = "The name of the bucket to store the final output"
  type = string
  default = "output"
}
