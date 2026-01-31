# This script destroys the Terraform-managed infrastructure.

echo "🚀 Destroying Terraform resources..."
cd "$(dirname "$0")/../iac"
terraform destroy --auto-approve
echo "✅ Terraform resources destroyed successfully!"