resource "aws_iam_role" "iam-role-project-lamdba-20220824-01"{
    name = "lambda-exec-role-project-lambda-20220824-01"
    # who can assume this role
    assume_role_policy = <<POLICY
    {
        "Version": "2012-10-17",
        "Statement": [{
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
            }]
    }
    POLICY
}

## Attaching policy to the role
resource "aws_iam_role_policy_attachment" "role-policy-project-lamdba-20220824-01"{
    role = aws_iam_role.iam-role-project-lamdba-20220824-01.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

}

### Should be done as the part of the pipeline
data "archive_file" "af-project-lambda-20220824-01" {
    type = "zip"
    source_dir = "./${path.module}/lambda"
    output_path = "./${path.module}/lambda_function_project_lamdba_20220824.zip"
}

resource "aws_lambda_function" "lambda-project-lambda-20220824-01" {
    function_name = "lambda-project-lambda-20220824-01"

    s3_bucket = aws_s3_bucket.s3-bucket-project-lamdba-20220824-01.id
    s3_key = aws_s3_object.s3-object-project-lambda-20220824-01.key

    runtime = "python3.7"
    handler = "function.handler"

    ## if the hash of the file is different it would force to redeploy lambda
    source_code_hash = data.archive_file.af-project-lambda-20220824-01.output_base64sha256

    role = aws_iam_role.iam-role-project-lamdba-20220824-01.arn
}

resource "aws_cloudwatch_log_group" "cw-project-lambda-20220824-01" {
  name              = "/aws/lambda/${aws_lambda_function.lambda-project-lambda-20220824-01.function_name}"
  retention_in_days = 14
}





