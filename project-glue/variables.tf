variable "query_results_s3_bucket_name" {
  type = string
  description = "s3 bucket to store query results (temporary)"
  default = "project-glue-query-results-20220825"
}

variable "datalake_s3_bucket_name" {
  type = string
  default = "project-glue-datalake-20220825"
}

variable "datalake_data_prefix" {
  type = string
  default = "datalake"
}
