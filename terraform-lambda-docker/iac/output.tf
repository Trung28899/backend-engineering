output "lambda_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.terraform_lambda.function_name
}

output "api_gateway_url" {
  description = "The public URL to invoke the Lambda function"
  value       = "${aws_apigatewayv2_stage.dev.invoke_url}/invoke"
}