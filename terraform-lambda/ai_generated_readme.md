# Terraform Lambda with API Gateway

A learning project demonstrating how to deploy a TypeScript Lambda function with API Gateway using Terraform.

## Project Overview

This project shows how to:
- Build and package a TypeScript Lambda function
- Deploy AWS Lambda using Terraform
- Create an API Gateway HTTP API as a trigger
- Manage infrastructure as code with Terraform
- Use deployment scripts for automation

## Architecture

```
Client (HTTP POST)
    ↓
API Gateway (HTTP API)
    ↓ /dev/invoke
Lambda Function
    ↓
Response (JSON)
```

## Project Structure

```
terraform-lambda/
├── backend/           # TypeScript Lambda source code
│   ├── src/          # Source files
│   ├── dist/         # Compiled JavaScript (generated)
│   └── lambda.zip    # Deployment package (generated)
├── bin/              # Deployment scripts
│   ├── deploy.sh     # Build and deploy everything
│   └── destroy.sh    # Tear down infrastructure
├── iac/              # Terraform infrastructure code
│   ├── lambda.tf     # Lambda function and IAM roles
│   ├── api_gateway.tf # API Gateway configuration
│   ├── providers.tf  # AWS provider configuration
│   ├── vars.tf       # Variables
│   └── output.tf     # Output values (API URL, etc.)
└── README.md         # This file
```

## Prerequisites

- [Node.js](https://nodejs.org/) (v18+)
- [Terraform](https://www.terraform.io/) (v1.0+)
- [AWS CLI](https://aws.amazon.com/cli/) configured with credentials
- AWS account with appropriate permissions

## Setup

1. **Clone or navigate to the project**
   ```bash
   cd terraform-lambda
   ```

2. **Install dependencies**
   ```bash
   cd backend
   npm install
   cd ..
   ```

3. **Configure AWS credentials**
   ```bash
   aws configure
   ```

## Deployment

Deploy everything with a single command:

```bash
./bin/deploy.sh
```

This script will:
1. Install backend dependencies
2. Compile TypeScript to JavaScript
3. Create a deployment package (zip)
4. Initialize Terraform
5. Deploy Lambda and API Gateway
6. Display the API URL

## Testing the API

After deployment, you'll see output like:

```
Outputs:

api_gateway_url = "https://abc123.execute-api.ca-central-1.amazonaws.com/dev/invoke"
lambda_name = "my-typescript-lambda"
```

**Test with curl:**
```bash
curl -X POST https://abc123.execute-api.ca-central-1.amazonaws.com/dev/invoke \
  -H "Content-Type: application/json" \
  -d '{"test": "data"}'
```

**Expected response:**
```json
{"message": "Hello from my amazing Lambda of destiny how are you doing!"}
```

## Viewing Outputs

Get the API URL anytime:
```bash
cd iac
terraform output api_gateway_url
```

View all outputs:
```bash
terraform output
```

## Cleanup

Destroy all infrastructure:
```bash
./bin/destroy.sh
```

Or manually:
```bash
cd iac
terraform destroy
```

## Key Components Explained

### Lambda Function ([iac/lambda.tf](iac/lambda.tf))
- Defines the Lambda function resource
- Sets up IAM execution role
- Configures CloudWatch logging

### API Gateway ([iac/api_gateway.tf](iac/api_gateway.tf))
- Creates HTTP API Gateway
- Sets up integration with Lambda
- Defines route: `POST /invoke`
- Creates `dev` stage with auto-deployment
- Grants API Gateway permission to invoke Lambda

### URL Structure

```
https://{api-id}.execute-api.{region}.amazonaws.com/{stage}/{route}
         └─────────────────┬────────────────────────┘  └──┬──┘ └──┬──┘
                      Base API URL                    Stage  Route
```

Example: `https://m2zm3lsqbc.execute-api.ca-central-1.amazonaws.com/dev/invoke`

## What I Learned

1. **Terraform Basics**
   - Resource definitions and dependencies
   - State management
   - Outputs for retrieving values
   - File organization (separating concerns)

2. **API Gateway Concepts**
   - HTTP API vs REST API
   - Stages (dev, prod, etc.)
   - Routes and methods
   - Integration types (AWS_PROXY)

3. **Lambda Configuration**
   - IAM roles and permissions
   - Execution policies
   - Handler configuration
   - Packaging for deployment

4. **AWS Permissions**
   - Lambda execution role
   - API Gateway invoke permissions
   - CloudWatch logging permissions

5. **Infrastructure as Code**
   - Version control for infrastructure
   - Reproducible deployments
   - Automated teardown

## Common Issues

### 404 Not Found
- Ensure you're using the complete URL with stage and route
- Correct: `https://api-id.../dev/invoke`
- Wrong: `https://api-id.../` or `https://api-id.../dev`

### Terraform Output Empty
- Run `terraform apply` first to deploy
- Check if resources exist: `terraform state list`

### Permission Denied
- Verify AWS credentials are configured
- Check IAM permissions for Lambda and API Gateway

## Next Steps

Ideas to extend this project:
- Add multiple routes (`GET /users`, `POST /orders`, etc.)
- Implement request validation
- Add environment variables
- Set up multiple stages (dev, staging, prod)
- Add DynamoDB integration
- Implement authentication with Lambda authorizers
- Add CloudWatch alarms and monitoring
- Set up CI/CD pipeline

## Resources

- [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS Lambda Documentation](https://docs.aws.amazon.com/lambda/)
- [API Gateway HTTP APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api.html)

---

Built as a learning project to understand Terraform, Lambda, and API Gateway.
