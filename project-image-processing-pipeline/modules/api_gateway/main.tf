resource "aws_api_gateway_rest_api" "this"{
    name = var.upload_api
}

resource "aws_api_gateway_resource" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id = aws_api_gateway_rest_api.this.root_resource_id
  path_part = "uploads"
}

resource "aws_api_gateway_method" "get"{
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.this.id
  http_method = "GET"
  authorization = "AWS_IAM"
}

resource "aws_api_gateway_integration" "get" {
  depends_on = [aws_api_gateway_method.get]
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.get.http_method
  #creates an integration type of MOCK, that instructs API Gateway to create a mock backend for GET /uploads
  type = "AWS"
  # Included because of this issue: https://github.com/hashicorp/terraform/issues/10501
  integration_http_method = "GET"
  # See uri description: https://docs.aws.amazon.com/apigateway/api-reference/resource/integration/
  uri         = "arn:aws:apigateway:${var.aws_region}:s3:path//"
  credentials = aws_iam_role.s3_full_access.arn
  #request_templates is required to explicitly set the statusCode to an integer value of 200
   request_templates = {
    "application/json" = jsonencode({
      statusCode = 200
    })
  }
}

resource "aws_api_gateway_method_response" "get_200"{
  depends_on = [aws_api_gateway_integration.get]
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.get.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Timestamp"      = true
    "method.response.header.Content-Length" = true
    "method.response.header.Content-Type"   = true
  }
}

resource "aws_api_gateway_integration_response" "get_200" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_integration.get.http_method
  status_code = aws_api_gateway_method_response.get_200.status_code
  response_parameters = {
    "method.response.header.Timestamp"      = "integration.response.header.Date"
    "method.response.header.Content-Length" = "integration.response.header.Content-Length"
    "method.response.header.Content-Type"   = "integration.response.header.Content-Type"
  }
}

resource "aws_api_gateway_method" "put"{
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.this.id
  http_method = "PUT"
  authorization = "AWS_IAM"
}

resource "aws_api_gateway_integration" "put" {
  depends_on = [aws_api_gateway_method.put]
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.put.http_method
  #creates an integration type of MOCK, that instructs API Gateway to create a mock backend for GET /uploads
  type = "AWS"
  # Included because of this issue: https://github.com/hashicorp/terraform/issues/10501
  integration_http_method = "GET"
  # See uri description: https://docs.aws.amazon.com/apigateway/api-reference/resource/integration/
  uri         = "arn:aws:apigateway:${var.aws_region}:s3:path//"
  credentials = aws_iam_role.s3_full_access.arn
  #request_templates is required to explicitly set the statusCode to an integer value of 200
   request_templates = {
    "application/json" = jsonencode({
      statusCode = 200
    })
  }
}