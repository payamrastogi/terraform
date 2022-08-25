resource "aws_iam_role" "iam_for_lambda" {
 name = "iam_for_lambda"
 # who can assume this role
 assume_role_policy = jsonencode({
   "Version" : "2012-10-17",
   "Statement" : [
     {
       "Effect" : "Allow",
       "Principal" : {
         "Service" : "lambda.amazonaws.com"
       },
       "Action" : "sts:AssumeRole"
     }
   ]
  })
}

# A Lambda function's execution role is an AWS Identity and Access Management (IAM) role 
# that grants the function permission to access AWS  services and resources. 
# You provide this role when you create a function, and Lambda assumes the role when your function is invoked.         
resource "aws_iam_role_policy_attachment" "lambda_policy" {
   role = aws_iam_role.iam_for_lambda.name
   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

#policy to perform actions on dynamodb          
resource "aws_iam_role_policy" "dynamodb-lambda-policy" {
   name = "dynamodb_lambda_policy"
   role = aws_iam_role.iam_for_lambda.id
   policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
           "Effect" : "Allow",
           "Action" : ["dynamodb:*"],
           "Resource" : "${aws_dynamodb_table.tf_notes_table.arn}"
        }
      ]
   })
}