provider "aws" {
  region = "ap-south-1" # change if needed
}

# S3 bucket for Lambda packages
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "ai-c2-less-lab-${random_id.bucket_id.hex}"
}

resource "random_id" "bucket_id" {
  byte_length = 4
}

# DynamoDB table to store task logs
resource "aws_dynamodb_table" "task_logs" {
  name         = "ai-c2less-task-logs"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "task_id"

  attribute {
    name = "task_id"
    type = "S"
  }
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "ai-c2less-lambda-exec"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Attach AWSLambdaBasicExecutionRole policy
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Coordinator Lambda
resource "aws_lambda_function" "coordinator" {
  function_name = "ai-c2less-coordinator"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "coordinator.lambda_handler"
  runtime       = "python3.9"

  s3_bucket = aws_s3_bucket.lambda_bucket.bucket
  s3_key    = "coordinator.zip"
}

# Agent Lambda
resource "aws_lambda_function" "agent" {
  function_name = "ai-c2less-agent"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "agent.lambda_handler"
  runtime       = "python3.9"

  s3_bucket = aws_s3_bucket.lambda_bucket.bucket
  s3_key    = "agent.zip"
}

# API Gateway
resource "aws_apigatewayv2_api" "api" {
  name          = "ai-c2less-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                 = aws_apigatewayv2_api.api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.coordinator.invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "route" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "POST /tasks"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "dev" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "dev"
  auto_deploy = true
}

output "api_endpoint" {
  value = aws_apigatewayv2_stage.dev.invoke_url
}
