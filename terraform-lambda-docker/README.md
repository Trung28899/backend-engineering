# Terraform-lambda-docker overview

- The goal of this project is to learn how terraform can be used to provision a lambda service configured with API Gateway. At the same time, explore how can Docker be used to enable Lambda local development.

- This project is a Node.js Typescript backend server that is configured with Terraform for provisioning infrastructure. Infrastructure resources provisioned in this folder includes:
  - A Lambda function
  - API gateway: that exposes a public endpoint as a trigger to invoke Lambda function

# Docker

1. **Docker Overview**

   Docker is setup to run the lambda locally. It comes with the following features:
   - Building the image locally
   - Running the image in a container (port 8080)
   - Hot Reload feature:
     ```
     TypeScript changes → Compile to JS (in dist) → Rebuild image → Restart container
     ```

2. **Running Lambda Locally**

   ```bash
     cd terraform-lambda-docker
     ./bin/run.sh
     # then press 'w' to enable Hot Reload feature
   ```

   - The lambda will then be available locally at this address:
     - http://localhost:8000/2015-03-31/functions/function/invocations
     - Notes: remember to send POST request with an empty body {}

# Terraform Setups & Commands

1. **Install dependencies**

   ```bash
   cd terraform-lambda-docker/backend
   npm install
   ```

2. **Commands**

- After deployment, API gateway in aws console will show an url like this:
  - https://m2zm3lsqbc.execute-api.ca-central-1.amazonaws.com/dev
- We need to add a /invoke route in order to send POST / GET requests

  ```bash
  cd terraform-lambda-docker
  ./bin/deploy.sh # deploying infrastructure
  ./bin/destroy.sh # destroying deployed infrastructure
  ```

3. **Terraform specific commands**
   - See more in shell scripts (deploy.sh & destroy.sh), but here are some notable commands:

   ```bash
   cd terraform-lambda-docker/iac
   terraform apply # apply all terraform files (for deployment)
   terraform destroy # destroy all terraform resources
   terraform output # output details specified in output.tf
   ```

# Project Structure

```
terraform-lambda-docker/
├── backend/           # TypeScript Lambda source code
│   ├── src/          # Source files
│   ├── dist/         # Compiled JavaScript (generated)
│   └── lambda.zip    # Deployment package (generated)
├── bin/              # Deployment scripts, ran `chmod +x ...sh` for all the .sh files here
│   ├── deploy.sh     # Build and deploy everything
│   └── destroy.sh    # Tear down infrastructure
│   └── run.sh        # Run the lambda locally
├── iac/              # Terraform infrastructure code
│   ├── lambda.tf     # Lambda function and IAM roles
│   ├── api_gateway.tf # API Gateway configuration
│   ├── providers.tf  # AWS provider configuration
│   ├── vars.tf       # Variables
│   └── output.tf     # Output values (API URL, etc.)
└── README.md         # This file
```
