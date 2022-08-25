# 1. Create S3 bucket with random id
# 2. Package as zip
# 3. Upload to S3
# 4. Create a lamdba and point to S3 zip

- IAM policy
1. PowerUserAccess
2. AWSLambdaFullAccess    

## Invoke lambda from console
- aws lambda invoke --region=us-east-1 --function-name=$(terraform output -raw function_name) response.json
- cat response.json

### Links
- https://learn.hashicorp.com/tutorials/terraform/lambda-api-gateway