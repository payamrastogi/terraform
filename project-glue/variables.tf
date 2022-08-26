variable "bucket_for_glue" {
  description = "Bucket for AWS Glue"
  default = "project-glue-20220825"
}

variable "glue_catalog_database" {
  description = "glue catalog database name"
  default = "glue-catalog-db-20220825"
}