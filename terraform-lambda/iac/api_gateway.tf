# Create the HTTP API Gateway
resource "aws_apigatewayv2_api" "lambda_api" {
  name          = "my-lambda-api"
  protocol_type = "HTTP"
}

# Create the integration between API Gateway and Lambda
resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.lambda_api.id
  integration_type = "AWS_PROXY"

  integration_method = "POST"
  integration_uri    = aws_lambda_function.terraform_lambda.invoke_arn
}

# Create a route for POST requests to /invoke
resource "aws_apigatewayv2_route" "lambda_route" {
  api_id    = aws_apigatewayv2_api.lambda_api.id
  route_key = "POST /invoke"

  target = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

# Create a dev stage with auto-deployment
resource "aws_apigatewayv2_stage" "dev" {
  api_id      = aws_apigatewayv2_api.lambda_api.id
  name        = "dev"
  auto_deploy = true
}

# Grant API Gateway permission to invoke the Lambda function
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.terraform_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # The source ARN references the API Gateway execution ARN
  # Format: arn:aws:execute-api:region:account-id:api-id/*/*/*
  # The */*/* allows any stage, method, and route to invoke this Lambda
  source_arn = "${aws_apigatewayv2_api.lambda_api.execution_arn}/*/*"
}
