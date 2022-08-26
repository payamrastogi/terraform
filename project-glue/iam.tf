resource "aws_iam_role" "aws_iam_glue_role" {
  name = "AWSGlueServiceRoleDefault"
  #who can assume this role
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "glue.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

# attach the policy to the role
resource "aws_iam_role_policy_attachment" "glue_service_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
  role = aws_iam_role.aws_iam_glue_role.id
}

## policy to allow actions on S3
resource "aws_iam_role_policy" "s3_policy" {
  name = "s3_policy"
  role = aws_iam_role.aws_iam_glue_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::${var.bucket_for_glue}",
        "arn:aws:s3:::${var.bucket_for_glue}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "glue_service_s3" {
  name = "glue_service_s3"
  role = aws_iam_role.aws_iam_glue_role.id
  policy = aws_iam_role_policy.s3_policy.policy
}