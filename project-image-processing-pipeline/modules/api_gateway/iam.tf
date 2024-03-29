# Create S3 Full Access Policy
resource "aws_iam_policy" "s3_full_access" {
  name        = "s3-full-access"
  description = "Policy for allowing all S3 Actions"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "*"
        }
    ]
}
EOF
}

# Create API Gateway Role
resource "aws_iam_role" "s3_full_access" {
  name = "s3-full-access"

  # Create Trust Policy for API Gateway
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
  EOF
}

# Attach S3 Full Access Policy to the API Gateway Role
resource "aws_iam_role_policy_attachment" "s3_full_access" {
  role       = aws_iam_role.s3_full_access.name
  policy_arn = aws_iam_policy.s3_full_access.arn
}