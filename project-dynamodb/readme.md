##invoke Lambda
- aws lambda invoke --region=us-east-1 --function-name=create-note output.json 
- aws lambda invoke --region=us-east-1 --function-name=get-all-notes output.json 

- https://dynobase.dev/dynamodb-terraform/
- https://docs.aws.amazon.com/lambda/latest/dg/lambda-intro-execution-role.html
- https://bobbyhadz.com/blog/aws-cdk-policy-arn-does-not-exist-error
- https://stackoverflow.com/questions/38529163/aws-iam-policy-to-allow-user-to-create-iam-roles-from-management-console-aws
- https://stackoverflow.com/questions/48577727/how-to-trigger-terraform-to-upload-new-lambda-code