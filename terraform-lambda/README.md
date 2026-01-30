# Terraform-lambda overview

- The goal of this project is to learn how terraform can be used to provision a lambda service configured with API Gateway

- This project is a Node.js Typescript backend server that is configured with Terraform for provisioning infrastructure. Infrastructure resources provisioned in this folder includes:
  - A Lambda function
  - API gateway: that exposes a public endpoint as a trigger to invoke Lambda function

# Setup & Commands

1. **Install dependencies**

   ```bash
   cd terraform-lambda/backend
   npm install
   ```

2. **Commands**

- After deployment, API gateway in aws console will show an url like this:
  - https://m2zm3lsqbc.execute-api.ca-central-1.amazonaws.com/dev
- We need to add a /invoke route in order to send POST / GET requests

  ```bash
  cd terraform-lambda/bin
  ./deploy.sh # deploying infrastructure
  ./destroy.sh # destroying deployed infrastructure
  ```

3. **Terraform specific commands**
   - See more in shell scripts (deploy.sh & destroy.sh), but here are some notable commands:

   ```bash
   cd terraform-lambda/iac
   terraform apply # apply all terraform files (for deployment)
   terraform destroy # destroy all terraform resources
   terraform output # output details specified in output.tf
   ```

# Project Structure

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
