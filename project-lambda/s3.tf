resource "random_pet" "random-id-project-lambda-20220824-01" {
    prefix = "lambda"
    length = 2
}

resource "aws_s3_bucket" "s3-bucket-project-lamdba-20220824-01"{
    bucket =  random_pet.random-id-project-lambda-20220824-01.id
    force_destroy = true
}

## block public access to the s3 bucket
resource aws_s3_bucket_public_access_block "s3-access-block-project-lamdba-20220824-01" {
    bucket = random_pet.random-id-project-lambda-20220824-01.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

## get the zip archive and upload it to s3 bucket
resource "aws_s3_object" "s3-object-project-lambda-20220824-01" {
  bucket = aws_s3_bucket.s3-bucket-project-lamdba-20220824-01.id
  key    = "lambda_function_project_lamdba_20220824.zip"
  source = data.archive_file.af-project-lambda-20220824-01.output_path

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  #trigger update if the value changes
  etag = filemd5(data.archive_file.af-project-lambda-20220824-01.output_path)
}
